function urldecode
    if python3 --version >/dev/null
        echo -n $argv | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()))"
    else
        echo "no python exiting..."
    end
end

