
local size = cc.Director:getInstance():getWinSize()
local function createDrawPrimitivesEffect()
    local layer = cc.Layer:create()

    -- InitTitle(layer)

    local glNode  = gl.glNodeCreate()
    glNode:setContentSize(cc.size(size.width, size.height))
    glNode:setAnchorPoint(cc.p(0.5, 0.5))

    local function primitivesDraw()
        cc.DrawPrimitives.drawLine(VisibleRect:leftBottom(), VisibleRect:rightTop() )

        gl.lineWidth( 5.0 )
        cc.DrawPrimitives.drawColor4B(255,0,0,255)
        cc.DrawPrimitives.drawLine( VisibleRect:leftTop(), VisibleRect:rightBottom() )



        cc.DrawPrimitives.setPointSize(64)
        cc.DrawPrimitives.drawColor4B(0, 0, 255, 128)
        cc.DrawPrimitives.drawPoint(VisibleRect:center())

        local points = {cc.p(60,60), cc.p(70,70), cc.p(60,70), cc.p(70,60) }
        cc.DrawPrimitives.setPointSize(4)
        cc.DrawPrimitives.drawColor4B(0,255,255,255)
        cc.DrawPrimitives.drawPoints(points,4)

        gl.lineWidth(16)
        cc.DrawPrimitives.drawColor4B(0, 255, 0, 255)
        cc.DrawPrimitives.drawCircle( VisibleRect:center(), 100, 0, 10, false)

        gl.lineWidth(2)
        cc.DrawPrimitives.drawColor4B(0, 255, 255, 255)
        cc.DrawPrimitives.drawCircle( VisibleRect:center(), 50, math.pi / 2, 50, true)

        gl.lineWidth(1)
        cc.DrawPrimitives.drawColor4B(255,255,255,255)
        cc.DrawPrimitives.setPointSize(1)

        kmGLPopMatrix()

        gl.lineWidth(10)
        cc.DrawPrimitives.drawColor4B(255, 255, 0, 255)
        local yellowPoints = { cc.p(0,0), cc.p(50,50), cc.p(100,50), cc.p(100,100), cc.p(50,100)}
        cc.DrawPrimitives.drawPoly( yellowPoints, 5, false)

        gl.lineWidth(1)
        local filledVertices = { cc.p(0,120), cc.p(50,120), cc.p(50,170), cc.p(25,200), cc.p(0,170) }
        cc.DrawPrimitives.drawSolidPoly(filledVertices, 5, cc.c4f(0.5, 0.5, 1, 1))

        gl.lineWidth(2)
        cc.DrawPrimitives.drawColor4B(255, 0, 255, 255)
        local closePoints= { cc.p(30,130), cc.p(30,230), cc.p(50,200) }
        cc.DrawPrimitives.drawPoly( closePoints, 3, true)

        cc.DrawPrimitives.drawQuadBezier(VisibleRect:leftTop(), VisibleRect:center(), VisibleRect:rightTop(), 50)

        cc.DrawPrimitives.drawCubicBezier(VisibleRect:center(), cc.p(VisibleRect:center().x + 30, VisibleRect:center().y + 50), cc.p(VisibleRect:center().x + 60,VisibleRect:center().y - 50), VisibleRect:right(), 100)

        local solidvertices = {cc.p(60,160), cc.p(70,190), cc.p(100,190), cc.p(90,160)}
        cc.DrawPrimitives.drawSolidPoly( solidvertices, 4, cc.c4f(1, 1, 0, 1) )

        local array = {
            cc.p(0, 0),
            cc.p(size.width / 2 - 30, 0),
            cc.p(size.width / 2 - 30, size.height - 80),
            cc.p(0, size.height - 80),
            cc.p(0, 0),
        }
        cc.DrawPrimitives.drawCatmullRom( array, 5)

        cc.DrawPrimitives.drawCardinalSpline( array, 0,100)

        gl.lineWidth(1)
        cc.DrawPrimitives.drawColor4B(255,255,255,255)
        cc.DrawPrimitives.setPointSize(1)
    end

    glNode:registerScriptDrawHandler(primitivesDraw)
    layer:addChild(glNode,-10)
    glNode:setPosition( size.width / 2, size.height / 2)

    Helper.initWithLayer(layer)
    Helper.titleLabel:setString("Draw primitives")
    Helper.subtitleLabel:setString("Drawing Primitives by call gl funtions")
    return layer
end

local function createDrawNodeTest()
    local layer = cc.Layer:create()

    -- InitTitle(layer)

    local draw = cc.DrawNode:create()
    layer:addChild(draw, 10)

    --Draw 10 circles
    for i=1, 10 do
        draw:drawDot(cc.p(size.width/2, size.height/2), 10*(10-i), cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
    end

    --Draw polygons
    points = { cc.p(size.height/4, 0), cc.p(size.width, size.height / 5), cc.p(size.width / 3 * 2, size.height) }
    draw:drawPolygon(points, table.getn(points), cc.c4f(1,0,0,0.5), 4, cc.c4f(0,0,1,1))

    local o = 80
    local w = 20
    local h = 50
    local star1 = { cc.p( o + w, o - h), cc.p(o + w * 2, o), cc.p(o + w * 2 + h, o + w), cc.p(o + w * 2, o + w * 2) }
    
    draw:drawPolygon(star1, table.getn(star1), cc.c4f(1,0,0,0.5), 1, cc.c4f(0,0,1,1))

    o = 180
    w = 20
    h = 50
    local star2 = {
        cc.p(o, o), cc.p(o + w, o - h), cc.p(o + w * 2, o),        --lower spike
        cc.p(o + w * 2 + h, o + w ), cc.p(o + w * 2, o + w * 2),      --right spike
        cc.p(o + w, o + w * 2 + h), cc.p(o, o + w * 2),               --top spike
        cc.p(o - h, o + w),                                              --left spike
    };
    
    draw:drawPolygon(star2, table.getn(star2), cc.c4f(1,0,0,0.5), 1, cc.c4f(0,0,1,1))

    draw:drawSegment(cc.p(20,size.height), cc.p(20,size.height/2), 10, cc.c4f(0, 1, 0, 1))

    draw:drawSegment(cc.p(10,size.height/2), cc.p(size.width/2, size.height/2), 40, cc.c4f(1, 0, 1, 0.5))

    Helper.initWithLayer(layer)
    Helper.titleLabel:setString("Test DrawNode")
    Helper.subtitleLabel:setString("Testing DrawNode - batched draws. Concave polygons are BROKEN")
    return layer
end

function DrawPrimitivesTest()
    local scene = cc.Scene:create()
    -- scene:addChild(drawPrimitivesMainLayer())
    -- scene:addChild(CreateBackMenuItem())
    Helper.curTest = "DrawPrimitivesTest"
    Helper.index = 1
    cclog("%s", Helper.curTest)
    Helper.createFunctionTable = {
        createDrawPrimitivesEffect,
        createDrawNodeTest
    }
    scene:addChild(createDrawPrimitivesEffect())
    scene:addChild(CreateBackMenuItem())
    return scene
end

