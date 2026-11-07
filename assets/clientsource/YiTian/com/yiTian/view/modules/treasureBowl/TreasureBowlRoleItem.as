package com.yiTian.view.modules.treasureBowl
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.model.Model_treasureBowl;
   import com.yiTian.data.vo.Vo_treasureBowl_role;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TreasureBowlRoleItem extends Sprite
   {
      
      private var _index:uint;
      
      private var head:Bitmap;
      
      private var roleName:MyTextField;
      
      private var money:MyTextField;
      
      public function TreasureBowlRoleItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":27,
            "y":0
         },Global.Img_Cdm);
         this.head = new Bitmap();
         this.head.x = 28.5;
         this.head.y = 1.5;
         this.addChild(this.head);
         this.roleName = ComponentUtil.getTextField("",this,{
            "x":21,
            "y":72,
            "color":8896312,
            "size":12,
            "leading":0
         });
         this.roleName.realWidth = 80;
         this.roleName.align = "center";
         this.money = ComponentUtil.getTextField("",this,{
            "x":2,
            "y":94,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.money.realWidth = 120;
         this.money.align = "center";
      }
      
      public function uqdate(index:uint) : void
      {
         var vo:Vo_treasureBowl_role = Model_treasureBowl.instace.getRoleVo(index);
         if(vo == null)
         {
            this.head.bitmapData = null;
            this.roleName.text = "";
            this.money.text = "";
            return;
         }
         var str:String = Const_strImg.getPlayerHead(vo.profession,vo.sex,0);
         this.head = Utils.getLoadBitmap(str,this.head);
         this.roleName.text = vo.name;
         this.money.text = LangConfig.getWord("70019",7) + (index + 1) + LangConfig.getWord("70020",7) + vo.money + " " + LangConfig.getWord("70018",7);
      }
   }
}

