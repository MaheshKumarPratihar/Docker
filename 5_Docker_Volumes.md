- Below command will pull ubuntu then create a file called `file` in folder `/tmp` then append it with `Hello there.` then `cat /tmp/file` i.e. show the contents of the created file

```bash
$ docker run --rm --entrypoint sh ubuntu -c "echo 'Hello there.' > /tmp/file && cat /tmp/file"
```

- But using `-v` and folder mapping similar to port mapping `outside:inside` we save the contents.

```bash
$ docker run --rm --entrypoint sh -v /tmp/container:/tmp  ubuntu -c "echo 'Hello there.' > /tmp/file && cat /tmp/file"
```

- Same can be done with file too, but file need to be exist in advance

```bash
$ docker run --rm --entrypoint sh -v /tmp/container/file:/tmp/file  ubuntu -c "echo 'Hello there.' > /tmp/file && cat /tmp/file"
```