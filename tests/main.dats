#include "../ats-libz.hats"

staload $LIBZ

implement main(argc, argv) = 0 where {
    val () = case argc of
            | 2 => println!("ARGS: ", argv[1])
            | _ => ()
    var destBuf = @[byte][1024](int2byte0 0)
    val text = "Hello World this is a string"
    var srcBuf = $UNSAFE.cast{ptr}(text)
    var destLen: lint = 1024l
    val srcLen: lint = $UNSAFE.cast{lint}(length(text))
    val _ = compress($UNSAFE.cast{ptr}(destBuf), destLen, srcBuf, srcLen)
    val () = println!($UNSAFE.cast{string}(destBuf))
    var uncompressedBuf = @[byte][1024](int2byte0 0)
    var originalLen: lint = 1024l
    val _ = uncompress($UNSAFE.cast{ptr}(uncompressedBuf), originalLen, $UNSAFE.cast{ptr}destBuf, destLen)
    val () = println!($UNSAFE.cast{string}(uncompressedBuf))
    val () = assertloc(originalLen = sz2i(length(text)))
}

