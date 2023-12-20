local helpers = {}
function helpers.hoverCursor(w, cursorType)
    cursorType = cursorType or 'hand2'
    local oldCursor = 'left_ptr'
    local wbx

    w.hcDisabled = false
    local enterCb = function()
        wbx = mouse.current_wibox
        if wbx then wbx.cursor = cursorType end
    end
    local leaveCb = function() if wbx then wbx.cursor = oldCursor end end

    w:connect_signal('hover::disconnect', function()
        w:disconnect_signal('mouse::enter', enterCb)
        w:disconnect_signal('mouse::leave', leaveCb)
        leaveCb()
    end)

    function w:toggleHoverCursor()
        w.hcDisabled = not w.hcDisabled
        if w.hcDisabled then
            leaveCb()
        else
            enterCb()
        end
    end

    w:connect_signal('mouse::enter', enterCb)
    w:connect_signal('mouse::leave', leaveCb)
end

-- i forgot what this does
helpers.inTable = function(t, v)
    for _, value in ipairs(t) do if value == v then return true end end
end
return helpers
