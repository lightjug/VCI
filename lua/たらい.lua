--このファイルコメントちゃんと入れてないごめんね。
---アイテムを生成したユーザーで毎フレーム呼ばれる

print("init")
vci.state.Set("isPlaySound",false)

function update()
end

function updateAll()

end

---[SubItemの所有権]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
end

---[SubItemの所有権]アイテムにCollider(Trigger)が接触したときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onTriggerEnter(item, hit)
end

---[SubItemの所有権]アイテムにCollider(Trigger)が離れたときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onTriggerExit(item, hit)
end

---[SubItemの所有権]アイテムにCollider(not Trigger)が接触したときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onCollisionEnter(item, hit)
    --print("ontrigger start")
    if vci.state.Get("isPlaySound") == false then
      print("called Trigger item:"..item.." hit:"..hit)
      vci.assets._ALL_PlayAudioFromIndex(0)
      vci.state.Set("isPlaySound",true)
    end
end

---[SubItemの所有権]アイテムにCollider(not Trigger)が離れたときに呼ばれる。
---@param item string @SubItem名
---@param hit string @Collider名
function onCollisionExit(item, hit)
end

---[SubItemの所有権]アイテムをGrabしたときに呼ばれる。
---@param target string @GrabされたSubItem名

function onGrab(target)

end

---[SubItemの所有権]アイテムをUngrabしたときに呼ばれる。
---@param target string @UngrabされたSubItem名
function onUngrab(target)

end


