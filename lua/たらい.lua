--このファイルコメントちゃんと入れてないごめんね。
---アイテムを生成したユーザーで毎フレーム呼ばれる

print("init")
vci.state.Set("isPlaySound",false)

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


