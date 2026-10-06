function send2alpine
    if test (count $argv) -eq 0
        echo "Usage: send2alpine <file_or_directory>"
        return 1
    end
    
    scp -r $argv root@192.168.1.126:/root/
end
