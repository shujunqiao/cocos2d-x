require "src/TransitionsTest/TransitionsName"


local SceneIdx = -1
local CurSceneNo = 2
local TRANSITION_DURATION = 1.2
local s = cc.Director:getInstance():getWinSize()

local function switchSceneTypeNo()
    if CurSceneNo == 1 then
        CurSceneNo = 2
    else
        CurSceneNo = 1
    end
end

local function backAction()
    SceneIdx = SceneIdx - 1
    if SceneIdx < 0 then
        SceneIdx = SceneIdx + Transition_Table.MAX_LAYER
    end

    switchSceneTypeNo()
    return generateTranScene()
end

local function restartAction()
    return generateTranScene()
end

local function nextAction()
    SceneIdx = SceneIdx + 1
    SceneIdx = math.mod(SceneIdx, Transition_Table.MAX_LAYER)

    switchSceneTypeNo()
    return generateTranScene()
end

local function backCallback(sender)
    local scene = backAction()
    cc.Director:getInstance():replaceScene(scene)
end

local function restartCallback(sender)
    local scene = restartAction()
    cc.Director:getInstance():replaceScene(scene)
end

local function nextCallback(sender)
    local scene = nextAction()
    cc.Director:getInstance():replaceScene(scene)
end

-----------------------------
-- TestLayer1
-----------------------------
local function createLayer1()
    local layer = cc.Layer:create()
    local x, y = s.width, s.height

    local bg1 = cc.Sprite:create(s_back1)
    bg1:setPosition(cc.p(s.width / 2, s.height / 2))
    layer:addChild(bg1, -1)

    local titleLabel = cc.Label:createWithTTF(Transition_Name[SceneIdx], s_thonburiPath, 32)
    layer:addChild(titleLabel)
    titleLabel:setColor(cc.c3b(255,32,32))
    titleLabel:setAnchorPoint(cc.p(0.5, 0.5))
    titleLabel:setPosition(x / 2, y - 100)

    local label = cc.Label:createWithTTF("SCENE 1", s_markerFeltFontPath, 38)
    label:setColor(cc.c3b(16,16,255))
    label:setAnchorPoint(cc.p(0.5, 0.5))
    label:setPosition(x / 2, y / 2)
    layer:addChild(label)

    -- menu
    local item1 = cc.MenuItemImage:create(s_pPathB1, s_pPathB2)
    local item2 = cc.MenuItemImage:create(s_pPathR1, s_pPathR2)
    local item3 = cc.MenuItemImage:create(s_pPathF1, s_pPathF2)
    item1:registerScriptTapHandler(backCallback)
    item2:registerScriptTapHandler(restartCallback)
    item3:registerScriptTapHandler(nextCallback)

    local menu = cc.Menu:create()
    menu:addChild(item1)
    menu:addChild(item2)
    menu:addChild(item3)
    menu:setPosition(cc.p(0, 0))
    item1:setPosition(cc.p(s.width / 2 - item2:getContentSize().width * 2, item2:getContentSize().height / 2))
    item2:setPosition(cc.p(s.width / 2, item2:getContentSize().height / 2))
    item3:setPosition(cc.p(s.width / 2 + item2:getContentSize().width * 2, item2:getContentSize().height / 2))

    layer:addChild(menu, 1)

    return layer
end

-----------------------------
-- TestLayer2
-----------------------------
local function createLayer2()
    local layer = cc.Layer:create()
    local x, y = s.width, s.height

    local bg1 = cc.Sprite:create(s_back2)
    bg1:setPosition(cc.p(s.width / 2, s.height / 2))
    layer:addChild(bg1, -1)

    local titleLabel = cc.Label:createWithTTF(Transition_Name[SceneIdx], s_thonburiPath, 32 )
    layer:addChild(titleLabel)
    titleLabel:setAnchorPoint(cc.p(0.5, 0.5))
    titleLabel:setColor(cc.c3b(255,32,32))
    titleLabel:setPosition(x / 2, y - 100)

    local label = cc.Label:createWithTTF("SCENE 2", s_markerFeltFontPath, 38)
    label:setColor(cc.c3b(16,16,255))
    label:setAnchorPoint(cc.p(0.5, 0.5))
    label:setPosition(x / 2, y / 2)
    layer:addChild(label)

    -- menu
    local item1 = cc.MenuItemImage:create(s_pPathB1, s_pPathB2)
    local item2 = cc.MenuItemImage:create(s_pPathR1, s_pPathR2)
    local item3 = cc.MenuItemImage:create(s_pPathF1, s_pPathF2)
    item1:registerScriptTapHandler(backCallback)
    item2:registerScriptTapHandler(restartCallback)
    item3:registerScriptTapHandler(nextCallback)

    local menu = cc.Menu:create()
    menu:addChild(item1)
    menu:addChild(item2)
    menu:addChild(item3)
    menu:setPosition(cc.p(0, 0))
    item1:setPosition(cc.p(s.width / 2 - item2:getContentSize().width * 2, item2:getContentSize().height / 2))
    item2:setPosition(cc.p(s.width / 2, item2:getContentSize().height / 2))
    item3:setPosition(cc.p(s.width / 2 + item2:getContentSize().width * 2, item2:getContentSize().height / 2))

    layer:addChild(menu, 1)

    return layer
end

-----------------------------
-- Create Transition Test
-----------------------------
local function createTransition(index, t, scene)
    cc.Director:getInstance():setDepthTest(false)

    if firstEnter == true then
        firstEnter = false
        return scene
    end

    if index == Transition_Table.CCTransitionJumpZoom then
        scene = cc.TransitionJumpZoom:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressRadialCCW then
        scene = cc.TransitionProgressRadialCCW:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressRadialCW then
        scene = cc.TransitionProgressRadialCW:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressHorizontal then
        scene = cc.TransitionProgressHorizontal:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressVertical then
        scene = cc.TransitionProgressVertical:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressInOut then
        scene = cc.TransitionProgressInOut:create(t, scene)
    elseif index == Transition_Table.CCTransitionProgressOutIn then
        scene = cc.TransitionProgressOutIn:create(t, scene)
    elseif index == Transition_Table.CCTransitionCrossFade then
        scene = cc.TransitionCrossFade:create(t, scene)
    elseif index == Transition_Table.TransitionPageForward then
        cc.Director:getInstance():setDepthTest(true)
        scene = cc.TransitionPageTurn:create(t, scene, false)
    elseif index == Transition_Table.TransitionPageBackward then
        cc.Director:getInstance():setDepthTest(true)
        scene = cc.TransitionPageTurn:create(t, scene, true)
    elseif index == Transition_Table.CCTransitionFadeTR then
        scene = cc.TransitionFadeTR:create(t, scene)
    elseif index == Transition_Table.CCTransitionFadeBL then
        scene = cc.TransitionFadeBL:create(t, scene)
    elseif index == Transition_Table.CCTransitionFadeUp then
        scene = cc.TransitionFadeUp:create(t, scene)
    elseif index == Transition_Table.CCTransitionFadeDown then
        scene = cc.TransitionFadeDown:create(t, scene)
    elseif index == Transition_Table.CCTransitionTurnOffTiles then
        scene = cc.TransitionTurnOffTiles:create(t, scene)
    elseif index == Transition_Table.CCTransitionSplitRows then
        scene = cc.TransitionSplitRows:create(t, scene)
    elseif index == Transition_Table.CCTransitionSplitCols then
        scene = cc.TransitionSplitCols:create(t, scene)
    elseif index == Transition_Table.CCTransitionFade then
        scene = cc.TransitionFade:create(t, scene)
    elseif index == Transition_Table.FadeWhiteTransition then
        scene = cc.TransitionFade:create(t, scene, cc.c3b(255, 255, 255))
    elseif index == Transition_Table.FlipXLeftOver then
        scene = cc.TransitionFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER )
    elseif index == Transition_Table.FlipXRightOver then
        scene = cc.TransitionFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER )
    elseif index == Transition_Table.FlipYUpOver then
        scene = cc.TransitionFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_UP_OVER)
    elseif index == Transition_Table.FlipYDownOver then
        scene = cc.TransitionFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_DOWN_OVER )
    elseif index == Transition_Table.FlipAngularLeftOver then
        scene = cc.TransitionFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER )
    elseif index == Transition_Table.FlipAngularRightOver then
        scene = cc.TransitionFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER )
    elseif index == Transition_Table.ZoomFlipXLeftOver then
        scene = cc.TransitionZoomFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER )
    elseif index == Transition_Table.ZoomFlipXRightOver then
        scene = cc.TransitionZoomFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER )
    elseif index == Transition_Table.ZoomFlipYUpOver then
        scene = cc.TransitionZoomFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_UP_OVER)
    elseif index == Transition_Table.ZoomFlipYDownOver then
        scene = cc.TransitionZoomFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_DOWN_OVER )
    elseif index == Transition_Table.ZoomFlipAngularLeftOver then
        scene = cc.TransitionZoomFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER )
    elseif index == Transition_Table.ZoomFlipAngularRightOver then
        scene = cc.TransitionZoomFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER )
    elseif index == Transition_Table.CCTransitionShrinkGrow then
        scene = cc.TransitionShrinkGrow:create(t, scene)
    elseif index == Transition_Table.CCTransitionRotoZoom then
        scene = cc.TransitionRotoZoom:create(t, scene)
    elseif index == Transition_Table.CCTransitionMoveInL then
        scene = cc.TransitionMoveInL:create(t, scene)
    elseif index == Transition_Table.CCTransitionMoveInR then
        scene = cc.TransitionMoveInR:create(t, scene)
    elseif index == Transition_Table.CCTransitionMoveInT then
        scene = cc.TransitionMoveInT:create(t, scene)
    elseif index == Transition_Table.CCTransitionMoveInB then
        scene = cc.TransitionMoveInB:create(t, scene)
    elseif index == Transition_Table.CCTransitionSlideInL then
        scene = cc.TransitionSlideInL:create(t, scene)
    elseif index == Transition_Table.CCTransitionSlideInR then
        scene = cc.TransitionSlideInR:create(t, scene)
    elseif index == Transition_Table.CCTransitionSlideInT then
        scene = cc.TransitionSlideInT:create(t, scene)
    elseif index == Transition_Table.CCTransitionSlideInB then
        scene = cc.TransitionSlideInB:create(t, scene)
    end

    return scene
end

function generateTranScene()
    local scene = cc.Scene:create()
    local layer = nil

    if CurSceneNo == 1 then
        layer = createLayer1()
    elseif CurSceneNo == 2 then
        layer = createLayer2()
    end

    Helper.initWithLayer(layer)
    Helper.titleLabel:setString(Transition_Name[SceneIdx])
    Helper.titleLabel:setVisible(false)

    scene:addChild(layer)
    scene:addChild(CreateBackMenuItem())

    return createTransition(SceneIdx, TRANSITION_DURATION, scene)
end

local function getSceneByIdx(idx)
    SceneIdx = idx
    switchSceneTypeNo()
    local scene = generateTranScene()
    scene:setTag(SCENE_TAG)
    return scene
end

local function CCTransitionJumpZoom()
    return getSceneByIdx(Transition_Table.CCTransitionJumpZoom)
end
local function CCTransitionProgressRadialCCW()
    return getSceneByIdx(Transition_Table.CCTransitionProgressRadialCCW)
end
local function CCTransitionProgressRadialCW()
    return getSceneByIdx(Transition_Table.CCTransitionProgressRadialCW)
end
local function CCTransitionProgressHorizontal()
    return getSceneByIdx(Transition_Table.CCTransitionProgressHorizontal)
end
local function CCTransitionProgressVertical()
    return getSceneByIdx(Transition_Table.CCTransitionProgressVertical)
end
local function CCTransitionProgressInOut()
    return getSceneByIdx(Transition_Table.CCTransitionProgressInOut)
end
local function CCTransitionProgressOutIn()
    return getSceneByIdx(Transition_Table.CCTransitionProgressOutIn)
end
local function CCTransitionCrossFade()
    return getSceneByIdx(Transition_Table.CCTransitionCrossFade)
end
local function TransitionPageForward()
    return getSceneByIdx(Transition_Table.TransitionPageForward)
end
local function TransitionPageBackward()
    return getSceneByIdx(Transition_Table.TransitionPageBackward)
end
local function CCTransitionFadeTR()
    return getSceneByIdx(Transition_Table.CCTransitionFadeTR)
end
local function CCTransitionFadeBL()
    return getSceneByIdx(Transition_Table.CCTransitionFadeBL)
end
local function CCTransitionFadeUp()
    return getSceneByIdx(Transition_Table.CCTransitionFadeUp)
end
local function CCTransitionFadeDown()
    return getSceneByIdx(Transition_Table.CCTransitionFadeDown)
end
local function CCTransitionTurnOffTiles()
    return getSceneByIdx(Transition_Table.CCTransitionTurnOffTiles)
end
local function CCTransitionSplitRows()
    return getSceneByIdx(Transition_Table.CCTransitionSplitRows)
end
local function CCTransitionSplitCols()
    return getSceneByIdx(Transition_Table.CCTransitionSplitCols)
end
local function CCTransitionFade()
    return getSceneByIdx(Transition_Table.CCTransitionFade)
end
local function FadeWhiteTransition()
    return getSceneByIdx(Transition_Table.FadeWhiteTransition)
end
local function FlipXLeftOver()
    return getSceneByIdx(Transition_Table.FlipXLeftOver)
end
local function FlipXRightOver()
    return getSceneByIdx(Transition_Table.FlipXRightOver)
end
local function FlipYUpOver()
    return getSceneByIdx(Transition_Table.FlipYUpOver)
end
local function FlipYDownOver()
    return getSceneByIdx(Transition_Table.FlipYDownOver)
end
local function FlipAngularLeftOver()
    return getSceneByIdx(Transition_Table.FlipAngularLeftOver)
end
local function FlipAngularRightOver()
    return getSceneByIdx(Transition_Table.FlipAngularRightOver)
end
local function ZoomFlipXLeftOver()
    return getSceneByIdx(Transition_Table.ZoomFlipXLeftOver)
end
local function ZoomFlipXRightOver()
    return getSceneByIdx(Transition_Table.ZoomFlipXRightOver)
end
local function ZoomFlipYUpOver()
    return getSceneByIdx(Transition_Table.ZoomFlipYUpOver)
end
local function ZoomFlipYDownOver()
    return getSceneByIdx(Transition_Table.ZoomFlipYDownOver)
end
local function ZoomFlipAngularLeftOver()
    return getSceneByIdx(Transition_Table.ZoomFlipAngularLeftOver)
end
local function ZoomFlipAngularRightOver()
    return getSceneByIdx(Transition_Table.ZoomFlipAngularRightOver)
end
local function CCTransitionShrinkGrow()
    return getSceneByIdx(Transition_Table.CCTransitionShrinkGrow)
end
local function CCTransitionRotoZoom()
    return getSceneByIdx(Transition_Table.CCTransitionRotoZoom)
end
local function CCTransitionMoveInL()
    return getSceneByIdx(Transition_Table.CCTransitionMoveInL)
end
local function CCTransitionMoveInR()
    return getSceneByIdx(Transition_Table.CCTransitionMoveInR)
end
local function CCTransitionMoveInT()
    return getSceneByIdx(Transition_Table.CCTransitionMoveInT)
end
local function CCTransitionMoveInB()
    return getSceneByIdx(Transition_Table.CCTransitionMoveInB)
end
local function CCTransitionSlideInL()
    return getSceneByIdx(Transition_Table.CCTransitionSlideInL)
end
local function CCTransitionSlideInR()
    return getSceneByIdx(Transition_Table.CCTransitionSlideInR)
end
local function CCTransitionSlideInT()
    return getSceneByIdx(Transition_Table.CCTransitionSlideInT)
end
local function CCTransitionSlideInB()
    return getSceneByIdx(Transition_Table.CCTransitionSlideInB)
end

function TransitionsTest()
    cclog("TransitionsTest")
    -- local scene = cc.Scene:create()

    SceneIdx = -1
    CurSceneNo = 2
    firstEnter = true

    Helper.curTest = "TransitionsTest"
    Helper.createFunctionTable = {
        CCTransitionJumpZoom,
        CCTransitionProgressRadialCCW,
        CCTransitionProgressRadialCW,
        CCTransitionProgressHorizontal,
        CCTransitionProgressVertical,
        CCTransitionProgressInOut,
        CCTransitionProgressOutIn,
        CCTransitionCrossFade,
        TransitionPageForward,
        TransitionPageBackward,
        CCTransitionFadeTR,
        CCTransitionFadeBL,
        CCTransitionFadeUp,
        CCTransitionFadeDown,
        CCTransitionTurnOffTiles,
        CCTransitionSplitRows,
        CCTransitionSplitCols,
        CCTransitionFade,
        FadeWhiteTransition,
        FlipXLeftOver,
        FlipXRightOver,
        FlipYUpOver,
        FlipYDownOver,
        FlipAngularLeftOver,
        FlipAngularRightOver,
        ZoomFlipXLeftOver,
        ZoomFlipXRightOver,
        ZoomFlipYUpOver,
        ZoomFlipYDownOver,
        ZoomFlipAngularLeftOver,
        ZoomFlipAngularRightOver,
        CCTransitionShrinkGrow,
        CCTransitionRotoZoom,
        CCTransitionMoveInL,
        CCTransitionMoveInR,
        CCTransitionMoveInT,
        CCTransitionMoveInB,
        CCTransitionSlideInL,
        CCTransitionSlideInR,
        CCTransitionSlideInT,
        CCTransitionSlideInB
    }
    local scene = (CCTransitionJumpZoom())
    -- scene:addChild(CreateBackMenuItem())

    return scene
    -- return nextAction()
end
