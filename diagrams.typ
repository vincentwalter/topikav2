// Incremental redraw of assets/taschenatlas_vehikel.jpg with CeTZ.
//
// All coordinates are pixel positions in the original image (1617 x 1536,
// y pointing down), so they can be read off the JPG directly. `unit` converts
// pixels to canvas length.

#import "@preview/cetz:0.3.4"

#let _img = "assets/taschenatlas_vehikel.jpg"
#let _img-size = (1617, 1536)
#let _scale = 155 // pixels per cm
#let _unit = 1cm / _scale
#let _extent = (1720, 1536)

#let _green = rgb("#B0D8C4")
#let _fill = rgb("#FFF7A5")
#let _ring-outer = rgb("#F8DD7F")
#let _ring-inner = rgb("#F5A623")
#let _red = rgb("#E3201B")

#let _p(pt) = (pt.at(0) / _scale, -pt.at(1) / _scale)

// Block arrow from `tail` to `tip`. The tail is meant to disappear below a
// circle that is drawn on top.
#let _arrow(tail, tip, w: 64, hw: 104, hl: 72) = {
  import cetz.draw: line
  let (dx, dy) = (tip.at(0) - tail.at(0), tip.at(1) - tail.at(1))
  let len = calc.sqrt(dx * dx + dy * dy)
  let (ux, uy) = (dx / len, dy / len)
  let (nx, ny) = (-uy, ux)
  let at(t, s) = _p((
    tail.at(0) + ux * t + nx * s,
    tail.at(1) + uy * t + ny * s,
  ))
  line(
    at(0, -w / 2),
    at(len - hl, -w / 2),
    at(len - hl, -hw / 2),
    at(len, 0),
    at(len - hl, hw / 2),
    at(len - hl, w / 2),
    at(0, w / 2),
    close: true,
    fill: _green,
    stroke: none,
  )
}

// Circle on the canvas, `r` in pixels.
#let _node(c, r, ring, thickness: 4) = {
  cetz.draw.circle(
    _p(c),
    radius: r / _scale,
    fill: _fill,
    stroke: ring + thickness * _unit,
  )
}

// Piece of the original JPG, `rect` = (x0, y0, x1, y1) in pixels. Used for the
// drawings inside the circles. With `r` the piece is cut to a circle around
// its centre. Circles are used because the JPG has arrows and labels right
// next to the circles.
#let _crop(rect, r: none) = {
  let (x0, y0, x1, y1) = rect
  let (w, h) = ((x1 - x0) * _unit, (y1 - y0) * _unit)
  cetz.draw.content(
    _p(((x0 + x1) / 2, (y0 + y1) / 2)),
    box(
      width: w,
      height: h,
      clip: true,
      radius: if r == none { 0pt } else { r * _unit },
      place(
        top + left,
        dx: -x0 * _unit,
        dy: -y0 * _unit,
        image(
          _img,
          width: _img-size.at(0) * _unit,
          height: _img-size.at(1) * _unit,
        ),
      ),
    ),
  )
}

#let _label(pos, body, anchor: "center") = cetz.draw.content(
  _p(pos),
  anchor: anchor,
  text(size: 12pt, body),
)

// Node positions (pixels)
#let _puder = (808, 160)
#let _fett = (185, 1293)
#let _wasser = (1431, 1293)
#let _paste = (388, 727)
#let _shake = (1229, 727)
#let _emul = (805, 1293)
#let _kuehl = (806, 728)

/// Step 1: triangle with empty circles in the corners.
/// Step 2: corners filled and labelled.
/// Step 3: complete diagram.
///
/// `debug: true` lays the original image underneath for comparison.
#let vehikel(step, debug: false) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Fixed extent, so that the canvas does not change size between steps. It
  // has to contain everything of the last step, labels included.
  rect(_p((0, 0)), _p(_extent), stroke: none)
  if debug {
    content(
      _p((0, 0)),
      anchor: "north-west",
      image(_img, width: _img-size.at(0) * _unit, scaling: "smooth"),
    )
    rect(_p((0, 0)), _p(_img-size), fill: white.transparentize(45%), stroke: none)
  }

  // Triangle, drawn along the axes of the arrows of the full diagram.
  // Its corners lie inside the corner circles.
  if step <= 2 {
    line(
      _p((808, 91)),
      _p((121, 1302)),
      _p((1495, 1302)),
      close: true,
      stroke: (
        paint: _green,
        thickness: 64 * _unit,
        join: "round",
      ),
    )
  }

  // Arrows lie below the circles.
  if step >= 3 {
    _arrow((740, 200), (528, 585)) // Puder -> Paste
    _arrow((876, 200), (1088, 585)) // Puder -> Schüttelmixtur
    _arrow((151, 1260), (355, 890)) // Fett -> Paste
    _arrow((1465, 1260), (1261, 890)) // Wasser -> Schüttelmixtur
    _arrow((388, 727), (632, 727)) // Paste -> Kühlpaste
    _arrow((1230, 727), (990, 727)) // Schüttelmixtur -> Kühlpaste
    _arrow((185, 1302), (652, 1302)) // Fett -> Emulsion
    _arrow((1431, 1302), (960, 1302)) // Wasser -> Emulsion
    _arrow((805, 1290), (805, 968)) // Emulsion -> Kühlpaste
  }

  // Circles
  for c in (_puder, _fett, _wasser) { _node(c, 135, _ring-outer) }
  if step >= 3 {
    for c in (_paste, _shake, _emul) { _node(c, 135, _ring-inner) }
    _node(_kuehl, 170, _red, thickness: 9)
  }

  // Drawings
  if step >= 2 {
    _crop((673, 25, 943, 295), r: 135) // Puder
    _crop((50, 1158, 320, 1428), r: 135) // Fett
    _crop((255, 1112, 435, 1195)) // Fett: Tubenende
    _crop((1297, 1158, 1567, 1428), r: 135) // Wasser
    _label((808, 323), [Puder])
    _label((333, 1400), [Fett, Öl, \ Fettsalbe], anchor: "west")
    _label((1238, 1380), [Wasser])
  }
  if step >= 3 {
    _crop((253, 592, 523, 862), r: 135) // Paste
    _crop((175, 385, 420, 600)) // Paste: Spatel
    _crop((175, 660, 330, 822)) // Paste: Deckel
    _crop((1095, 592, 1365, 862), r: 135) // Schüttelmixtur
    _crop((670, 1158, 940, 1428), r: 135) // Emulsion
    _crop((626, 400, 986, 900)) // Kühlpaste
    _label((243, 850), [Paste])
    _label((1445, 850), [Schüttelmixtur])
    _label((808, 922), [„Kühlpaste“])
    _label((716, 1472), [Emulsionen, \ Creme], anchor: "west")
  }
})
