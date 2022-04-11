if -x ~/.cargo/bin/lsd
    function ls
        lsd $argv
    end
end
