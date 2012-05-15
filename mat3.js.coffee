RAD_TO_DEGREE = Math.PI / 180
cos = Math.cos
sin = Math.sin

class Mat3

  constructor: ->
    @reset()
    
  reset: ->
    @_a = @_d = 1
    @_c = @_b = @_tx = @_ty = 0
    undefined

  scale: (hor, ver, centerX, centerY) ->
    @translate(centerX, centerY)
    
    @_a *= hor
    @_c *= hor
    @_b *= ver
    @_d *= ver
    
    @translate(-centerX, -centerY)
    undefined

  translate: (x, y) ->
    @_tx += x * @_a + y * @_b
    @_ty += x * @_c + y * @_d
    undefined

  # radAngle = angle * RAD_TO_DEGREE
  rotate: (angle, x, y) ->
    aCos  = cos(angle)
    aSin = sin(angle)
    
    @concatenate(aCos, aSin, -aSin, aCos, x - x * aCos + y * aSin, y - x * aSin - y * aCos)
    undefined

  concatenate: (_a, _c, _b, _d, _tx, _ty) ->
    a = @_a
    b = @_b
    c = @_c
    d = @_d
    @_a = _a * a + _c * b
    @_b = _b * a + _d * b
    @_tx += _tx * a + _ty * b
    @_c = _a * c + _c * d
    @_d = _b * c + _d * d
    @_ty += _tx * c + _ty * d
    undefined

  applyToContext: (ctx) ->
    ctx.transform(@_a, @_c, @_b, @_d, @_tx, @_ty)
    undefined

# Do more exports stuff for Node/AMD later
@Mat3 = Mat3