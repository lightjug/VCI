--------------------------------------------------------------------
--処理概要
--　・useで血吸開始。もう1回で止まる
--　・maxまでいったあとに血吸し直すと最初から
--TODO：
--　・モデルをもっときれいに
--　・マジックナンバーの削除
--　・他のユーザーがつかったときの確認
--　・ランプとスイッチを血吸と同期
--　・逆流機能
--------------------------------------------------------------------

local count = 0
local bloodAmount = 0
local vacuumFg

function init()
  --血液の非表示。ほかのVCIitemで最初からscale0だと上手くいかなかったため初期で0にしてる
  if vci.assets.IsMine then --途中で入ってきたユーザーで初期化されないようにmineを入れてる。あってるかは知らん
    for i = 1, 6 do
      local bloodRoot = vci.assets.GetSubItem("血液_Root ("..i..")")
      bloodRoot.SetLocalScale(Vector3.__new(0,0,0))
    end
  end
end
init()


---アイテムを生成したユーザーで毎フレーム呼ばれる
function update()
  local root = vci.assets.GetSubItem("吸血機")
  local pumpRoot = vci.assets.GetSubItem("ポンプ_Root")
  local injectCol = vci.assets.GetSubItem("注射判定用")
  local rootPos = root.GetLocalPosition()
 
  --位置同期。一部決め打ちコードが有るため直したい
  --血液
  for i = 1, 6 do
    local blood = vci.assets.GetSubItem("血液_Root ("..i..")")
    blood.SetLocalPosition(Vector3.__new(rootPos.x,0.875,rootPos.z))
    blood.SetLocalRotation(root.GetLocalRotation())
  end
  --ポンプ
  pumpRoot.SetLocalPosition(root.GetLocalPosition()+Vector3.__new(0,0.431,0))
  pumpRoot.SetLocalRotation(root.GetLocalRotation())
  --コライダー
  injectCol.SetLocalPosition(root.GetLocalPosition()+Vector3.__new(0,-0.4,0))
  injectCol.SetLocalRotation(root.GetLocalRotation())

  --ポンプ上下
  local h = 0.5 + 0.5*math.abs((count-50)/50)
  if vacuumFg == true then
    --ポンプの拡縮
    pumpRoot.SetLocalScale(Vector3.__new(1,h,1))
    --採血
    bloodAmount = bloodAmount + 1
    for i = 1, 6 do
      local h = (count)/100
      local h = (math.max(math.min(bloodAmount-(i-1)*250,250),0))/250
      local blood = vci.assets.GetSubItem("血液_Root ("..i..")")
      blood.SetLocalScale(Vector3.__new(1,h,1))
    end
  else
    pumpRoot.SetLocalScale(Vector3.__new(1,1,1))
  end

  count = count%100 + 1
end

---[SubItemの所有権]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
  if vacuumFg ~= true then
    if bloodAmount >= 250*6 then 
      bloodAmount = 0
    end
    vci.assets._ALL_PlayAudioFromName("Vacuum")
  else
    vci.assets._ALL_StopAudioFromName("Vacuum")
  end
  vacuumFg = not(vacuumFg)
end



