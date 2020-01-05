[CmdletBinding()]

PARAM(

    [string]$FolderPath = "C:\Screenshots",
    [string]$BaseImageName = "screenshot",
    [int]$TimeBetweenScreenshotInSeconds = 1,
    [int]$NumberOfScreenShots = 5,
    [int]$TimeToGetReadyInSeconds = 60
)

[Reflection.Assembly]::LoadWithPartialName("System.Drawing")

function New-Screenshot([Drawing.Rectangle]$bounds, $path) {
   
   $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
   $graphics = [Drawing.Graphics]::FromImage($bmp)

   $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

   $bmp.Save($path)

   $graphics.Dispose()
   $bmp.Dispose()

}

sleep -Seconds $TimeToGetReadyInSeconds

$bounds = [Drawing.Rectangle]::FromLTRB(0, 0, 1920, 1080)
$i = 0

while ($i -lt $NumberOfScreenShots) {

    $path = "$($FolderPath)\$($BaseImageName)$($i).png"
    New-Screenshot $bounds $path
    $i++
    sleep -Seconds $TimeBetweenScreenshotInSeconds 

}
