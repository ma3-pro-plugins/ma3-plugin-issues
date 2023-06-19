local signalTable = select(3, ...);
local my_handle = select(4, ...);

local numOfItems = 25
local itemWithSignal = false

local function createPopup(display)
    local popup = display.ModalOverlay:Append("Popup")
    popup.rows = 2
    popup[1][1].sizePolicy = "Fixed"
    popup[1][1].size = 50
    popup[1][2].sizePolicy = "Content"
    -- popup[1][2].size = 100

    return popup
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
    titleBarTitle.text = "Issue: Delete multiple items"
    return titleBar
end

local function createDialogFrame(popup)
    local frame = popup:Append("DialogFrame")
    frame[1][1].sizePolicy = "Content"
    -- frame[1][1].sizePolicy = "Fixed"
    -- frame[1][1].size = 600
    return frame
end

local function createGrid(parent, rows)
    local grid = parent:Append("UILayoutGrid")
    grid.name = "ItemContainer"
    grid.rows = rows
    for i = 1, rows do
        grid[1][i].sizePolicy = "Content"
        -- grid[1][i].sizePolicy = "Fixed"
        -- grid[1][i].size = 50
    end
    grid.anchors = "0,0"
    return grid
end

local function createMessage(parent, row)
    local uiObject = parent:Append("UIObject")
    uiObject.anchors = "0," .. row
    uiObject.contentDriven = 'Yes'
    uiObject.hasHover = 'No'
    uiObject.h = 50
    uiObject.text = "Click the button to delete items. Then move the dialog window, and see it's height change."
end

local function createItem(parent, itemNumber, row)
    local uiObject = parent:Append("UIObject")
    uiObject.anchors = "0," .. row
    uiObject.hasHover = 'No'
    uiObject.h = 50
    uiObject.text = "Item " .. itemNumber

    if itemWithSignal then
        uiObject.clicked = ":onButtonClicked"
        uiObject.pluginComponent = my_handle
    end
end

local function createMainButton(parent, row)
    local button = parent:Append("Button")
    button.anchors = "0," .. row
    button.h = 100
    button.text = "Delete all his friends"
    button.clicked = ":onButtonClicked"
    button.pluginComponent = my_handle
end
local function createButtons(parent, row)
    for i = 0, (numOfItems - 1) do

        local button = parent:Append("Button")
        button.anchors = "0," .. row + 1 + i
        button.h = 50
        button.text = "Delete Me and all my friends " .. tostring(i + 1)
        button.clicked = ":onButtonClicked"
        button.pluginComponent = my_handle
    end
end

signalTable.onButtonClicked = function(caller)
    Echo("Button clicked ")
    local overlay = GetTopOverlay(1)
    local container = overlay:FindRecursive("ItemContainer")
    Echo(container:Count())
    -- Delete 5th child multiple times
    for i = 1, numOfItems do
        container:Delete(5)
    end
    Echo(container:Count())
    Echo('Add BUtton')
    createButtons(container, 1)
    -- for i = 0, numOfItems - 1 do
    --     createItem(container, i + 1, i + 2)
    -- end
    Echo('End')
end

return function(display)
    Echo("Start")
    local popup = createPopup(display)
    createTitleBar(popup)
    local frame = createDialogFrame(popup)
    local grid = createGrid(frame, numOfItems + 2)
    createMessage(grid, 0)
    createMainButton(grid, 1)
    createButtons(grid, 2)
    -- for i = 0, numOfItems - 1 do
    --     createItem(grid, i + 1, i + 2)
    -- end
end

