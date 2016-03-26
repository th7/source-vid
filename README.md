# Source Vid

Generate gource videos from a public https repository

## Dependencies:
- Ruby 2.3.0
- git
- gource
- ffmpeg

## Limitations

It doesn't actually work. The views are 100% "throw something on the page for now". The video processing was difficult to control programmatically and is stubbed to just copy a pre-generated file.

## "Highlights"

I spent most of my time on the background processing. The VideoWorker collaborates with the Repository model, GitAdapter, and VideoAdapter. The intention was for the VideoWorker to tell the high level story of tracking and executing the processing while the collaborators encapsulate more of the details.

The VideoWorkerSpec does not test status transitions as processing occurs. It would have been better to set expectations that the underlying repository will receive messages to update its state in the correct order. I do think there's an interesting discussion to be had regarding what level of testing is appropriate for "table of contents" type classes that merely compose collaborators while holding minimal functionality themselves. I've seen them devolve into tests of "did I write the code I wrote?"

The GitAdapter class uses a pattern like:

```
begin
  yield something
ensure
  # cleanup
end
```

which I find very useful in any case where something is written out but not intended to be kept. It's also a useful pattern where something should be 'undone' if the block exits with an exception, exa.

```
stop_old_process
begin
  yield
rescue => e
  restart_old_process
  raise e
end
```


