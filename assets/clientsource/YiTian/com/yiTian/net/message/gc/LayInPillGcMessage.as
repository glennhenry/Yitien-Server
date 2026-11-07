package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_layInPill;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class LayInPillGcMessage
   {
      
      public function LayInPillGcMessage(index:Array)
      {
         super();
         index[MessageType.gc_layIn_pill] = this.gc_layIn_pill;
         index[MessageType.gc_layIn_pill_result] = this.gc_layIn_pill_result;
      }
      
      private function gc_layIn_pill(patch:IDataInput) : void
      {
         if(GameUnitManager.hero.level < 40)
         {
            return;
         }
         var currentExp:String = patch.readUTF();
         var highestExp:String = patch.readUTF();
         Model_layInPill.instance.currentExp = currentExp;
         Model_layInPill.instance.highestExp = highestExp;
         if(Boolean(int(currentExp)))
         {
            if(!Model_layInPill.instance.eff)
            {
               Model_layInPill.instance.eff = EffectManager.addEffect("35147",UIManager.mainMenu,1000,UIManager.mainMenu.layInImg.x + 6,UIManager.mainMenu.layInImg.y + 6,true);
            }
         }
         else if(Boolean(Model_layInPill.instance.eff))
         {
            EffectManager.removeEffect(Model_layInPill.instance.eff);
            Model_layInPill.instance.eff = null;
         }
         if(Boolean(UIManager.mainMenu.sprite))
         {
            TipManager.bind(UIManager.mainMenu.sprite,LangConfig.getWord("180",9,Model_layInPill.instance.currentExp,Model_layInPill.instance.highestExp));
         }
      }
      
      private function gc_layIn_pill_result(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            if(!Model_layInPill.instance.eff)
            {
               Model_layInPill.instance.eff = EffectManager.addEffect("35147",UIManager.mainMenu,1000,UIManager.mainMenu.layInImg.x + 5,UIManager.mainMenu.layInImg.y + 6,true);
            }
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("181",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("179",9));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("177",9));
         }
      }
   }
}

