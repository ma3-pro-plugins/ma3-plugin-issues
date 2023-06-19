local signalTable = select(3, ...);
local my_handle = select(4, ...);

local numOfItems = 5
signalTable.onButtonClicked = function(caller)
    Echo("Button clicked ")
    local overlay = GetTopOverlay(1)
    local container = overlay:FindRecursive("ItemContainer")
    Echo(container:Count())
    -- Delete until there are 4 items left: Rows, Columns , Message and the Button
    for i = container:Count(), 5, -1 do
        container:Delete(i)
    end
    Echo(container:Count())
end

return function(display)

    local function createPopup()
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
        titleBarTitle.text = "Issue: Dialog Size After Delete"
        return titleBar
    end

    local function createDialogFrame(popup)
        local frame = popup:Append("DialogFrame")
        -- frame[1][1].sizePolicy = "Content"
        frame[1][1].sizePolicy = "Content"
        -- frame[1][1].size = 600
        return frame
    end

    local function createGrid(parent, rows)
        local grid = parent:Append("UILayoutGrid")
        grid.name = "ItemContainer"
        grid.rows = rows
        for i = 1, rows do
            grid[1][i].sizePolicy = "Content"
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

    Echo("Start")
    local popup = createPopup()
    createTitleBar(popup)
    local frame = createDialogFrame(popup)
    local grid = createGrid(frame, numOfItems + 2)
    createMessage(grid, 0)
    createButton(grid, 1)
    for i = 0, numOfItems - 1 do
        createItem(grid, i + 1, i + 2)
    end

end
