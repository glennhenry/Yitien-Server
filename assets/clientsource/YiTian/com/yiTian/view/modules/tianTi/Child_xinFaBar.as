package com.yiTian.view.modules.tianTi
{
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.manager.TipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_xinFaBar extends Sprite
   {
      
      public static const tf_offset:Number = 15;
      
      public static var posArr:Array = [50,0,-80,0,50,0,50,0,-80,0];
      
      private var sb:Child_xinFaSB;
      
      private var tf_name:MyTextField;
      
      private var tf_lv:MyTextField;
      
      private var pb_exp:MaskProgressBar;
      
      private var _lv:int;
      
      private var _exp:int;
      
      private var _level:int;
      
      private var _type:int;
      
      public function Child_xinFaBar()
      {
         var bm:Bitmap = null;
         var bm_bar:Bitmap = null;
         super();
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":50,
            "realWidth":80,
            "bold":true
         });
         this.tf_name.autoSize = TextFieldAutoSize.CENTER;
         this.tf_lv = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":17,
            "realWidth":80,
            "bold":true
         });
         this.tf_lv.autoSize = TextFieldAutoSize.CENTER;
         this.pb_exp = new MaskProgressBar();
         bm = ComponentUtil.getBitmap("Pet_ProgressBG",this,null,Global.Scenedm);
         this.pb_exp.bg = bm;
         bm_bar = ComponentUtil.getBitmap("Pet_HP",this,null,Global.Scenedm);
         bm_bar.y = 1;
         this.pb_exp.bar = bm_bar;
         this.pb_exp.init();
         this.pb_exp.realWidth = 60;
         addChild(this.pb_exp);
         this.level = 1;
      }
      
      public function set type(value:uint) : void
      {
         this.tf_name.color = this.tf_lv.color = Enum_ZhangMenRen.colorArr[value - 1];
         this._type = value;
      }
      
      public function init() : void
      {
         var index:int = 0;
         if(!this.sb)
         {
            this.sb = new Child_xinFaSB();
            addChild(this.sb);
         }
         index = this._type - 1;
         this.tf_name.text = Enum_ZhangMenRen.xinFaNames[index];
         this.tf_name.x = posArr[index * 2] + 10;
         this.tf_name.y = posArr[index * 2 + 1];
         this.tf_lv.x = this.tf_name.x;
         this.tf_lv.y = this.tf_name.y + tf_offset;
         this.pb_exp.x = this.tf_lv.x - 2;
         this.pb_exp.y = this.tf_lv.y + tf_offset + 4;
         this.sb.type = this._type;
         addEventListener(MouseEvent.MOUSE_MOVE,this.rollOverHd);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
         this.pb_exp.container.transform.colorTransform = Util[Enum_ZhangMenRen.transformArr[index]];
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      private function rollOverHd(evt:MouseEvent) : void
      {
         var vo:Vo_xinFa = new Vo_xinFa();
         vo.exp = this._exp;
         vo.type = this.type;
         vo.lv = this.level;
         vo.isGod = Model_ZhangMenRen.isGod;
         TipManager.update(vo);
      }
      
      private function rollOutHd(evt:MouseEvent) : void
      {
         if(evt.target == this)
         {
            TipManager.hide();
         }
      }
      
      public function set level(value:uint) : void
      {
         this._level = value;
         this.tf_lv.text = "Lv." + value.toString();
      }
      
      public function get level() : uint
      {
         return this._level;
      }
      
      public function set exp(value:uint) : void
      {
         this._exp = value;
         var datalib:DictionaryTabel = Model_ZhangMenRen.isGod ? Data_lib.xinfakuozhan : Data_lib.xinfa;
         var countExp:int = int(datalib[Enum_ZhangMenRen.findXinID(this.type,this.level)][1]);
         if(this.level < 100 || this.level > 100)
         {
            this.pb_exp.persent = value / countExp;
         }
         else if(this.level == 100 || this.level == 150)
         {
            this.pb_exp.persent = 1;
         }
      }
      
      public function updata() : void
      {
         var index:int = this._type - 1;
         this.tf_name.text = Enum_ZhangMenRen.xinFaNames[index];
      }
   }
}

