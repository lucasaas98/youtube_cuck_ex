defmodule YoutubeCuck.Workers.RSSFeedWorker do
  use Oban.Worker,
    max_attempts: 3

  require Logger

  alias YoutubeCuck.Repos.Channel, as: ChannelRepo
  alias YoutubeCuck.Repos.Video, as: VideoRepo

  # 7 days
  @max_time 604_800

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{type: :subscriptions}}) do
    # Retrieve all subscriptions
    subscriptions = ChannelRepo.list_subscribed_channels()

    # go through each one and request updates
    results =
      subscriptions
      |> Enum.map(fn subscription ->
        downloaded_videos_urls =
          VideoRepo.list_downloaded_videos_by_channel(subscription.id)
          |> Enum.map(fn video -> video.video_url end)

        response = HTTPoison.get!(subscription.rss_url)

        feed_video_list = XmlToMap.naive_map(response.body)["feed"]["entry"]

        feed_video_list
        |> Enum.each(fn entry ->
          {:ok, release_time, _} = DateTime.from_iso8601(entry["published"])
          video_url = entry["link"]["-href"]

          if DateTime.diff(release_time, DateTime.utc_now()) < -@max_time do
            Logger.info("Skipping video #{video_url}. Too old.")
          else
            if Enum.member?(downloaded_videos_urls, video_url) do
              Logger.info("Skipping video #{video_url}. Already downloaded.")
            else
              create_video_from_entry(entry, subscription.id)
              |> schedule_video_worker()
            end
          end
        end)
      end)
  end

  # def perform(%Oban.Job{args: %{type: :playlist}}) do
  #   # Retrieve all subscriptions
  #   subscriptions = ChannelRepo.list_subscribed_channels()

  #   # go through each one and request updates
  #   results =
  #     subscriptions
  #     |> Enum.map(fn subscription ->
  #       response = HTTPoison.get!(subscription.rss_url)

  #       mapped_response = XmlToMap.naive_map(response.body)["feed"]
  #     end)
  # end

  defp create_video_from_entry(entry, channel_id) do
    publication_date = DateTime.from_iso8601(entry["published"]) |> elem(1)

    %{
      video_id: entry["yt:videoId"],
      video_url: entry["link"]["-href"],
      thumbnail_url: entry["media:group"]["media:thumbnail"]["-url"],
      publication_date: publication_date,
      publication_date_human: publication_date |> Calendar.strftime("%a, %B %d %Y"),
      title: entry["media:group"]["media:title"],
      view_count:
        entry["media:group"]["media:community"]["media:statistics"]["-views"] |> Integer.parse(),
      description: entry["media:group"]["media:description"],
      channel_id: channel_id
    }
    |> VideoRepo.create_video()
  end

  defp schedule_video_worker(video) do
    YoutubeCuck.Workers.VideoDownloadWorker.new(%{video: video})
    |> Oban.insert!()
  end
end
