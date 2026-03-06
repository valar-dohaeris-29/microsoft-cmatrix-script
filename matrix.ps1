$width = [console]::WindowWidth
$height = [console]::WindowHeight

$streams = @()

for ($i = 0; $i -lt $width; $i++) {
    $streams += [pscustomobject]@{
        head = Get-Random -Minimum (-$height) -Maximum 0
        length = Get-Random -Minimum 6 -Maximum 20
    }
}

[console]::CursorVisible = $false
Clear-Host

while ($true) {

    for ($x = 0; $x -lt $width; $x++) {

        $stream = $streams[$x]

        # draw stream
        for ($i = 0; $i -lt $stream.length; $i++) {

            $y = $stream.head - $i

            if ($y -ge 0 -and $y -lt $height) {

                [console]::SetCursorPosition($x,$y)
                $char = [char](Get-Random -Minimum 33 -Maximum 126)

                if ($i -eq 0) {
                    Write-Host $char -ForegroundColor White -NoNewline
                }
                else {
                    Write-Host $char -ForegroundColor Green -NoNewline
                }
            }
        }

        # erase tail
        $eraseY = $stream.head - $stream.length
        if ($eraseY -ge 0 -and $eraseY -lt $height) {
            [console]::SetCursorPosition($x,$eraseY)
            Write-Host " " -NoNewline
        }

        $stream.head++

        if ($stream.head - $stream.length -gt $height) {
            $stream.head = Get-Random -Minimum (-$height) -Maximum 0
            $stream.length = Get-Random -Minimum 6 -Maximum 20
        }
    }

    Start-Sleep -Milliseconds 1
}