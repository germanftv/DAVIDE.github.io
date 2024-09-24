for i in *.$1
do
  # Generate cover image
  ffmpeg -i $i -vframes 1 -vf scale=$2:-2 -q:v 1 new/${i%$1}jpg
  # Generate WebM
  ffmpeg -i $i -c:v libvpx -qmin 0 -qmax 25 -crf 4 -b:v 1M -vf scale=$2:-2 -an -threads 0 new/${i%$1}webm
  # Generate MP4
  ffmpeg -i $i -c:v libx264 -pix_fmt yuv420p -profile:v baseline -level 3.0 -crf 22 -preset veryslow -vf scale=$2:-2 -an -movflags +faststart -threads 0 new/${i%$1}mp4
done