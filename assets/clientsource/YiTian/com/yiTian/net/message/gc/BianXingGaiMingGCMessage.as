package com.yiTian.net.message.gc
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Alert;
   import flash.utils.IDataInput;
   
   public class BianXingGaiMingGCMessage
   {
      
      public function BianXingGaiMingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GAI_MING] = this.GC_GAI_MING;
         index[MessageType.GC_FAIL_PROMPT] = this.GC_FAIL_PROMPT;
         index[MessageType.GC_CHANGE_BANGNAME] = this.GC_CHANGE_BANGNAME;
      }
      
      private function GC_FAIL_PROMPT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("名字不能与其它玩家重复");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("背包没有改名卡");
         }
      }
      
      private function GC_GAI_MING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var sex:int = patch.readByte();
         var name:String = patch.readUTF();
         if(result == 1)
         {
            GameUnitManager.hero.name = name;
            GameUnitManager.hero.nameBar.show();
            UIManager.heroHead.update();
            UIManager.friendPanel.updateMyName(name);
            View_Alert.show("恭喜您成功修改姓名",View_Alert.OK);
         }
         else if(result == 2)
         {
            GameUnitManager.hero.sex = sex;
            UIManager.heroHead.loadHeroHead();
            View_Alert.show("恭喜您成功转换性别",View_Alert.OK);
         }
      }
      
      private function GC_CHANGE_BANGNAME(patch:IDataInput) : void
      {
         var tipStr:String = null;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               tipStr = "成功修改帮会名称";
               break;
            case 2:
               tipStr = "您不是帮主，无法修改帮会名称";
               break;
            case 3:
               tipStr = "帮会战进行期间不能修改帮会名称";
               break;
            case 4:
               tipStr = "该名称与其他帮会名称冲突";
         }
         if(Boolean(tipStr))
         {
            UIManager.centerBroadcast.addMsg(tipStr);
         }
      }
   }
}

