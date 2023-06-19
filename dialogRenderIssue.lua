local signalTable = select(3, ...);
local my_handle = select(4, ...);

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
        titleBarTitle.text = "Title3"
        return titleBar
    end

    local function createDialogFrame(popup)
        local frame = popup:Append("DialogFrame")
        -- frame[1][1].sizePolicy = "Content"
        frame[1][1].sizePolicy = "Fixed"
        frame[1][1].size = 600
        return frame
    end

    local function createGrid(parent)
        local grid = parent:Append("UILayoutGrid")
        grid.rows = 3
        grid[1][1].sizePolicy = "Content"
        grid[1][2].sizePolicy = "Content"
        grid[1][3].sizePolicy = "Content"
        grid.anchors = "0,0"
        return grid
    end

    local function createText(parent)
        local uiObject = parent:Append("UIObject")
        uiObject.anchors = "0,1"
        uiObject.contentDriven = 'Yes'
        uiObject.h = 100
        uiObject.text = "Hello MA"
    end

    local function createLineEdit(parent)
        Echo('createLineEdit')
        local lineEdit = parent:Append("LineEdit")
        lineEdit.anchors = "0,2"
        lineEdit.contentDriven = 'Yes'
        lineEdit.h = 100
        lineEdit.content = "value"
        signalTable.onTextChanged = function()
            Echo('Text Changed')
        end
        lineEdit:Set('textChanged', ":onTextChanged")
        lineEdit:Set('pluginComponent', my_handle)
    end

    local function createButton(parent)
        local button = parent:Append("Button")
        button.anchors = "0,0"
        button.contentDriven = 'Yes'
        button.h = 100
        button.text = "Click Me"
        button.clicked = ":onButtonClicked"
        signalTable.onButtonClicked = function()
            Echo("Button clicked (Delete children 4,, createText, createLineEdit)")
            parent:Delete(4)

            button.clicked = nil
            signalTable.onButtonClicked = nil

            button.clicked = ":onButtonClicked"
            signalTable.onButtonClicked = function()
                Echo("NO MORE")
            end
            createLineEdit(parent)
        end
        button.pluginComponent = my_handle
    end

    Echo("Start")
    local popup = createPopup()
    createTitleBar(popup)
    local frame = createDialogFrame(popup)
    local grid = createGrid(frame)
    createButton(grid)
    createLineEdit(grid)

end
