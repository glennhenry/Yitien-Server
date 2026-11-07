package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class Child_ZhuFuInfo2 extends Sprite
   {
      
      private var bm_roleHead:Bitmap2;
      
      private var tf_roleName:MyTextField;
      
      private var shp_mask:Shape;
      
      private var tf_star1:MyTextField;
      
      private var tf_abb1:MyTextField;
      
      private var tf_star2:MyTextField;
      
      private var tf_abb2:MyTextField;
      
      private var pb:MaskProgressBar;
      
      private var tf_blessValue:MyTextField;
      
      private var _disMaxExp:int = 1;
      
      private var bSelected:Boolean = false;
      
      private var _data:Array;
      
      public function Child_ZhuFuInfo2()
      {
         super();
         this.init2();
      }
      
      public function init2() : void
      {
         ComponentUtil.getBitmap("Winner_Back",this,{
            "x":56,
            "y":2
         },Global.kuafuzhan_Imgsdm);
         var creatorObj:Array = [[Bitmap2,{
            "y":9,
            "name":"bm"
         }],[MyTextField,{
            "text":"",
            "x":94,
            "y":93,
            "name":"rolename",
            "color":8896312,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":94,
            "y":123,
            "name":"star1",
            "color":16776960,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":94,
            "y":156,
            "name":"abb1",
            "color":65280,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":94,
            "y":203,
            "name":"star2",
            "color":16776960,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":94,
            "y":234,
            "name":"abb2",
            "color":65280,
            "autoSize":TextFieldAutoSize.CENTER
         }]];
         ViewerCreator.createViewer(creatorObj,this);
         this.bm_roleHead = getChildByName("bm") as Bitmap2;
         this.tf_roleName = getChildByName("rolename") as MyTextField;
         this.tf_star1 = getChildByName("star1") as MyTextField;
         this.tf_abb1 = getChildByName("abb1") as MyTextField;
         this.tf_star2 = getChildByName("star2") as MyTextField;
         this.tf_abb2 = getChildByName("abb2") as MyTextField;
         var pbBG:Bitmap = ComponentUtil.getBitmap("ZFProgress_Back",null,{"x":-8},Global.kuafuzhan_Imgsdm);
         var pbBar:Bitmap = ComponentUtil.getBitmap("ZFProgress",null,{"y":6},Global.kuafuzhan_Imgsdm);
         this.pb = new MaskProgressBar();
         this.pb.bar = pbBar;
         this.pb.bg = pbBG;
         ComponentUtil.setPropertie(this.pb,{
            "x":18,
            "y":270,
            "realWidth":168
         });
         this.pb.init();
         addChild(this.pb);
         this.tf_blessValue = ComponentUtil.getTextField("",this.pb,{
            "x":this.pb.realWidth / 2,
            "autoSize":TextFieldAutoSize.CENTER
         });
         this.shp_mask = new Shape();
         this.shp_mask.graphics.beginFill(16777215);
         this.shp_mask.graphics.drawCircle(0,32.5,32.5);
         this.shp_mask.x = 97;
         this.shp_mask.y = 9;
         this.shp_mask.graphics.endFill();
         addChild(this.shp_mask);
         this.bm_roleHead.mask = this.shp_mask;
      }
      
      public function set bmScaleX(number:Number) : void
      {
         if(number == 1)
         {
            this.bm_roleHead.x = 32.5 + 163 - 128;
         }
         else
         {
            this.bm_roleHead.x = -32.5 + 163;
         }
         this.bm_roleHead.scaleX = number;
      }
      
      public function play(disLV:int, disStar:int, disExp:int, costTime:int = 1500) : void
      {
         this._disMaxExp = HuaShanUtil.getBlessAbbArr(disLV,disStar)[2];
         var disPercent:Number = this._disMaxExp == 0 ? 1 : disExp / this._disMaxExp;
         if(this._disMaxExp == 0)
         {
            this.pb.persent = 1;
            this.tf_blessValue.text = "0/0";
         }
         else
         {
            Tween.to(this,costTime,{"persent":[0,disPercent]},null,null,Tween.EASYINOUT);
         }
      }
      
      public function set persent(num:Number) : void
      {
         this.tf_blessValue.text = int(num * this._disMaxExp) + "/" + this._disMaxExp;
         this.pb.persent = num;
      }
      
      public function set selected(b:Boolean) : void
      {
         this.bSelected = b;
      }
      
      public function get selected() : Boolean
      {
         return this.bSelected;
      }
      
      public function update(obj:Object) : void
      {
         this._data = obj as Array;
         var roleID:int = int(this._data[Enum_HuaShan.CONT_ID]);
         var roleName:String = this._data[Enum_HuaShan.CONT_ROLENAME];
         var lv:int = int(this._data[Enum_HuaShan.CONT_ROLELV]);
         var strength:int = int(this._data[Enum_HuaShan.CONT_ROLESTRENGTH]);
         var roleSex:int = int(this._data[Enum_HuaShan.CONT_ROLESEX]);
         var roleJob:int = int(this._data[Enum_HuaShan.CONT_ROLEJOB]);
         var blessLV:int = int(this._data[Enum_HuaShan.CONT_BLESSLV]);
         var blessStar:int = int(this._data[Enum_HuaShan.CONT_BLESSSTAR]);
         var blessExp:int = int(this._data[Enum_HuaShan.CONT_BLESSEXP]);
         var str_roleHeadUrl:String = Const_strImg.getPlayerHead(roleJob,roleSex);
         this.tf_roleName.text = roleName;
         this.tf_abb1.text = HuaShanUtil.getBlessAbbStr(blessLV,blessStar);
         var total:int = blessLV * 11 + blessStar + 1;
         var nxtLv:int = int(total / 11);
         var nxtStar:int = total % 11;
         this.tf_star1.text = LangConfig.getWord("29350",2,blessLV,blessStar);
         if(nxtLv < 10)
         {
            this.tf_star2.text = Util.rep(LangConfig.getWord("29351",2) + LangConfig.getWord("29350",2),nxtLv,nxtStar);
         }
         else
         {
            this.tf_star2.text = LangConfig.getWord("29352",2);
         }
         this.tf_abb2.text = HuaShanUtil.getBlessAbbStr(nxtLv,nxtStar);
         this.bm_roleHead.load(str_roleHeadUrl,1);
         this.play(blessLV,blessStar,blessExp,2000);
      }
   }
}

