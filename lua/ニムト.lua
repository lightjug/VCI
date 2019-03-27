--------------------------------------------------------------------
--処理概要
--v1.0
--　・山札クリックでカード出現
--　(他の人から回転して出るように見えることがあるらしい。(他の人が使ったとき限定？))
--TODO：
--　・引くときランダムではなくてちゃんとシャッフルする
--　・捨て札昨日(見えるパターン・見えないパターン)
--　・山札の上に戻す(数枚見て並び替えも)
--　・山札の下に戻す
--　・パンデミックみたいにシャッフルにルールがあるものの実現
--------------------------------------------------------------------

local cardList = {}
local isDrawingFlg = false
local nowCardName = ""
local drawCounter = 0

function init()
  print("init")
  for i = 1, 103 do
     table.insert(cardList,"Card ("..i..")")
  end
  vci.state.Set("isCliking",false)
end

init()

function update()
  if isDrawingFlg == true then
    drawCounter = drawCounter + 1
    local targetCard = vci.assets.GetSubItem(nowCardName)
    local deck = vci.assets.GetSubItem("Deck")
    --print(deck.GetForward())
    targetCard.SetPosition(targetCard.GetPosition() + 2.1*deck.GetForward())
    --targetCard.SetLocalPosition(targetCard.GetLocalPosition() + 0.1*deck.GetForward())
    if drawCounter > 10 then 
      drawCounter = 0
      isDrawingFlg = false
      print("drawEnd")
    end
  end

  if vci.state.Get("isCliking")then
    vci.state.Set("isCliking",false)

    if #cardList > 0 then
      local index = math.random(1, #cardList)
      local cardName = table.remove(cardList, index)
      local targetCard = vci.assets.GetSubItem(cardName)
      local deck = vci.assets.GetSubItem("Deck")
      print(targetCard.GetName())
      --print(deck.GetLocalPosition())
      targetCard.SetPosition(deck.GetPosition() + 1*deck.GetForward())
      --targetCard.SetLocalPosition(deck.GetLocalPosition() + Vector3.__new(0,0,1)) --1*deck.GetForward())
      targetCard.SetLocalRotation(deck.GetLocalRotation())

      nowCardName = targetCard.GetName()
      isDrawingFlg = true
    end
  end
end

---[SubItemの所有権]アイテムをグラッブしてグリップボタンを押すと呼ばれる。
---@param use string @押されたアイテムのSubItem名
function onUse(use)
  if use == "Deck" and vci.state.Get("isCliking") == false then
    vci.state.Set("isCliking",true)
  end
end

function shuffle()
end

