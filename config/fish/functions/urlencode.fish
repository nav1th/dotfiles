function urlencode
    if python3 --version >/dev/null
        echo -n $argv | python3 -c "import sys; from urllib.parse import quote; print(quote(sys.stdin.read()))"
    else
        echo "no python exiting..."
    end
end
