local signalTable = select(3, ...);
local my_handle = select(4, ...);

signalTable.onButtonClicked = function(caller)

    function handleClick()
        local overlay = GetTopOverlay(1)
        local container = overlay:FindRecursive("ItemContainer")
        container:Delete(4) -- 4 is the button
        for i = 1, 50000 do
            Echo('Count is: ' .. tostring(i))
        end
    end

    local useWorkaround = true
    if useWorkaround then
        -- The Workaround is to use a Timer to handle this in a new thread
        Timer(handleClick, 0, 1)
    else
        handleClick()
    end
end

local function createTitleBar(popup)
    local titleBar = popup:Append("TitleBar")
    titleBar.texture = 'corner2'
    titleBar.anchors = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0
    }

    local titleBarTitle = titleBar:Append('TitleButton')
    titleBarTitle.anchors = "0,0"
    titleBarTitle.texture = 'corner3'
    titleBarTitle.text = "Issue: Dialog Size After Delete"
    return titleBar
end

local function createDialogFrame(popup)
    local frame = popup:Append("DialogFrame")
    frame[1][1].sizePolicy = "Content"
    return frame
end

local function createPopupWithFrame(display)
    local popup = display.ModalOverlay:Append("Popup")
    popup.rows = 2
    popup[1][1].sizePolicy = "Fixed"
    popup[1][1].size = 50
    popup[1][2].sizePolicy = "Content"
    createTitleBar(popup)
    local frame = createDialogFrame(popup)
    return frame
end

local function createGrid(parent)
    local grid = parent:Append("UILayoutGrid")
    grid.name = "ItemContainer"
    grid.rows = 2
    grid[1][1].sizePolicy = "Content"
    grid[1][2].sizePolicy = "Content"
    grid.anchors = "0,0"
    return grid
end

local function createMessage(parent, row)
    local uiObject = parent:Append("UIObject")
    uiObject.anchors = "0," .. row
    uiObject.contentDriven = 'Yes'
    uiObject.hasHover = 'No'
    uiObject.backColor = Root().ColorTheme.ColorGroups.Global.Background
    uiObject.h = 100
    uiObject.text =
        "Click the button to delete itself and count to 50000.\nYou will see in the SystemMonitor that the count is aborted."
end

local function createItem(parent, itemNumber, row)
    local uiObject = parent:Append("UIObject")
    uiObject.anchors = "0," .. row
    uiObject.hasHover = 'No'
    uiObject.h = 50
    uiObject.text = "Item " .. itemNumber
end

local function createButton(parent, row)
    local button = parent:Append("Button")
    button.anchors = "0," .. row
    button.contentDriven = 'Yes'
    button.h = 100
    button.text = "Click Me"
    button.clicked = ":onButtonClicked"
    button.pluginComponent = my_handle
end

local function Main(display, argument)
    local frame = createPopupWithFrame(display)
    local grid = createGrid(frame)
    createMessage(grid, 0)
    createButton(grid, 1)
end

return Main
