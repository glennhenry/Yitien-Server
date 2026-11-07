package com.yiTian.view.modules.crossClanBattle
{
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CrossClanRoleBuffer extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var strArr:Array = ["攻击力","攻速","伤害加成"];
      
      private var strArrDes:Array = ["%","点","%"];
      
      private var bm_bg:Bitmap = new Bitmap();
      
      public function CrossClanRoleBuffer()
      {
         super();
         addChild(this.bm_bg);
      }
      
      public static function get instance() : CrossClanRoleBuffer
      {
         return Boolean(pool.length) ? pool.pop() : new CrossClanRoleBuffer();
      }
      
      public function update(sprIndex:int, count:int) : void
      {
         this.bm_bg = Utils.getLoadBitmap("resource/image/buff/" + Model_CrossClanBattle.roleBuffArr[sprIndex][Enum_CrossClanBattle.BUFF_ICON] + ".png",this.bm_bg);
         TipManager.bind(this,"增加" + int(Model_CrossClanBattle.roleBuffArr[sprIndex][Enum_CrossClanBattle.BUFF_VALUE]) * count + this.strArrDes[sprIndex] + this.strArr[sprIndex]);
      }
      
      public function dispose() : void
      {
         if(Boolean(this.bm_bg))
         {
            removeChild(this.bm_bg);
         }
         this.bm_bg = null;
         pool.push(this);
      }
   }
}

