import GObject from 'gi://GObject';
import Icon from 'resource:///com/github/Aylur/ags/widgets/icon.js';
import GdkPixbuf from 'gi://GdkPixbuf';

class PixelatedIcon extends Icon {
  static { GObject.registerClass(this); }

  pixelatePixbuf(pixbuf, pixelSize) {
    let width = pixbuf.get_width();
    let height = pixbuf.get_height();
    let resultPixbuf = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, pixbuf.get_has_alpha(), 8, width, height);

    for (let y = 0; y < height; y += pixelSize) {
      for (let x = 0; x < width; x += pixelSize) {
        let rSum = 0, gSum = 0, bSum = 0, aSum = 0;

        for (let j = 0; j < pixelSize; j++) {
          for (let i = 0; i < pixelSize; i++) {
            let pixel = pixbuf.get_pixel(x + i, y + j);
            rSum += pixel.red;
            gSum += pixel.green;
            bSum += pixel.blue;
            aSum += pixel.alpha;
          }
        }

        let numPixels = pixelSize * pixelSize;
        let avgColor = new GdkPixbuf.Color();
        avgColor.red = rSum / numPixels;
        avgColor.green = gSum / numPixels;
        avgColor.blue = bSum / numPixels;
        avgColor.alpha = aSum / numPixels;

        for (let j = 0; j < pixelSize; j++) {
          for (let i = 0; i < pixelSize; i++) {
            resultPixbuf.fill(avgColor, x + i, y + j, 1, 1);
          }
        }
      }
    }

    return resultPixbuf;
  }

  constructor({ icon, ...rest }) {
    const pixelSize = 10;

    const originalPixbuf = typeof icon === 'string'
      ? GdkPixbuf.Pixbuf.new_from_file(icon)
      : icon;

    const pixelatedPixbuf = this.pixelatePixbuf(originalPixbuf, pixelSize);

    super({ icon: pixelatedPixbuf, ...rest });
  }
}

export default params => new PixelatedIcon(params);