return function(display)

    local function createPopup()
        local popup = display.ModalOverlay:Append("Popup")
        popup.rows = 2
        popup[1][1].sizePolicy = "Fixed"
        popup[1][1].size = 50
        popup[1][2].sizePolicy = "Content"

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
        titleBarTitle.text = "Issue: Dialog window size change"
        return titleBar
    end

    local function createDialogFrame(popup)
        local frame = popup:Append("DialogFrame")
        frame[1][1].sizePolicy = "Content"
        -- The issue does NOT occur if sizePolicy is "Fixed" or "Stretch"
        -- frame[1][1].sizePolicy = "Stretch"
        -- frame[1][1].sizePolicy = "Fixed"
        -- frame[1][1].size = 200
        return frame
    end

    local function createGrid(parent, rows)
        local grid = parent:Append("UILayoutGrid")
        grid.rows = rows
        grid[1][1].sizePolicy = "Content"
        -- The Issue still occurs if the sizePolicy is "Fixed"
        -- grid[1][1].sizePolicy = "Fixed"
        -- grid[1][1].size = "100"

        grid.anchors = "0,0"
        return grid
    end

    local function createMessage(parent, row)
        local uiObject = parent:Append("UIObject")
        uiObject.anchors = "0," .. row
        uiObject.contentDriven = 'Yes'
        uiObject.hasHover = 'No'
        uiObject.text = "Move the dialog window, and see it's height change."
    end

    Echo("Start")
    local popup = createPopup()
    createTitleBar(popup)
    local frame = createDialogFrame(popup)
    local grid = createGrid(frame, 2)
    createMessage(grid, 0)

end
