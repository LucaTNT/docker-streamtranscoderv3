This generates a Docker image for the venerable streamTranscoderV3 (which is so old its original website, oddsock.org, is offline).

streamTranscoderV3 connects to an Icecast (or Shoutcast) server and transcodes the stream to MP3 or OGG, then broadcasts the converted stream to an Icecast (or Shoutcast) server. The source and destination servers can be the same one, which is the most common use case.

## Usage

The resulting Docker image needs to be configured through environment variables, the first four are required.

### Example run command

	docker run -td -e SOURCE_URL=http://172.17.0.2:8000/mp3 -e SERVER=172.17.0.2 -e SERVER_PASSWORD=pass -e SERVER_MOUNTPOINT=/restream lucatnt/streamtranscoderv3

### Configuration environment variables

| Variable             | Required | Default            | Description                                                                                                                                       |
|----------------------|----------|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `SOURCE_URL`         | **Yes**  |                    | The source stream's URL. Icecast streams have a mount point (e.g. http://server:port/mountpoint), Shoutcast ones do not (e.g. http://server:port) |
| `SERVER`             | **Yes**  |                    | The server the transcoded stream will be sent to                                                                                                  |
| `SERVER_PASSWORD`    | **Yes**  |                    | The password of the server the transcoded stream will be sent to                                                                                  |
| `SERVER_MOUNTPOINT`  | **Yes**  |                    | The mountpoint on the server the transcoded stream will be sent to                                                                                |
| `SERVER_TYPE`        | No       | Icecast2           | Either `Icecast2` or `Shoutcast`. It's the type of the server the stream will be sent to                                                          |
| `PORT`               | No       | 8000               | The port of the server the transcoded stream will be sent to                                                                                      |
| `SERVER_STREAM_URL`  | No       |                    | Metadata, the URL field of the transcoded stream (can be anything, not related to the actual stream URL)                                          |
| `SERVER_NAME`        | No       |                    | Metadata, the name of the transcoded stream                                                                                                       |
| `SERVER_DESCRIPTION` | No       |                    | Metadata, the description of the transcoded stream                                                                                                |
| `SERVER_GENRE`       | No       |                    | Metadata, the genre of the transcoded stream                                                                                                      |
| `ENCODE`             | No       | MP3                | The format to encode to. Can be `MP3` or `OggVorbis`                                                                                              |
| `BITRATE_NOMINAL`    | No       | 128                | The nominal bitrate of the encoded stream (in kbps)                                                                                               |
| `BITRATE_MIN`        | No       | `$BITRATE_NOMINAL` | The minimum bitrate for the transcoded stream (ABR Mode)                                                                                          |
| `BITRATE_MAX`        | No       | `$BITRATE_NOMINAL` | The maximum bitrate for the transcoded stream (ABR Mode)                                                                                          |
| `NUMBER_CHANNELS`    | No       | 2                  | 1 = Mono, 2 = Stereo                                                                                                                              |
| `SAMPLE_RATE`        | No       | 44100              | The sample rate of the encoded stream                                                                                                             |
| `LOG_LEVEL`          | No       | 2                  | Log Level: 1 = LOG_ERROR, 2 = LOG_ERROR+LOG_INFO, 3 = LOG_ERROR+LOG_INFO+LOG_DEBUG                                                                |