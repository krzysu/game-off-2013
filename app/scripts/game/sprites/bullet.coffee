Q = Game.Q

Q.Sprite.extend "Bullet",
  init: (p) ->
    @_super p,
      color: "red"
      range: Q.width/2
      w: 8
      h: 8
      speed: 700
      gravity: 0
      type: Game.SPRITE_BULLET
      collisionMask: Game.SPRITE_TILES | Game.SPRITE_ENEMY

    @add("2d")

    @p.initialX = @p.x
    @p.initialY = @p.y

    @on "hit", @, "collision"

  draw: (ctx) ->
    ctx.fillStyle = @p.color;
    ctx.fillRect(-@p.cx, -@p.cy, @p.w, @p.h)

  step: (dt) ->
    if @p.direction == "left"
      @p.vx = -@p.speed
    else
      @p.vx = @p.speed

    if @p.x > Game.map.width || @p.x < 0
      @destroy()

    if @p.x > @p.initialX + @p.range or @p.x < @p.initialX - @p.range
      @destroy()

  collision: (col) ->
    @p.x -= col.separate[0]
    @p.y -= col.separate[1]
    @destroy()

