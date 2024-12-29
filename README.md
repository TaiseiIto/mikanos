# My [MikanOS](https://github.com/uchan-nos/mikanos) builder

## Build MikanOS

Execute the below commands.

```
/somewhere/in/the/host $ git clone https://github.com/TaiseiIto/mikanos.git
/somewhere/in/the/host $ cd mikanos
/somewhere/in/the/host/mikanos $ make build
```

Then, the MikanOS image file `disk.img` and mounted directory `disk` is generated.

## Run MikanOS

Execute the below commands.

```
/somewhere/in/the/host $ git clone https://github.com/TaiseiIto/mikanos.git
/somewhere/in/the/host $ cd mikanos
/somewhere/in/the/host/mikanos $ make run
```

Then, connect from a VNC client to `localhost:5900` according to [RFB protocol](https://datatracker.ietf.org/doc/html/rfc6143) to operate MikanOS.

