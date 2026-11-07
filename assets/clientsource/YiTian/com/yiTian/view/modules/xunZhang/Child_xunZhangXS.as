package com.yiTian.view.modules.xunZhang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.XunZhangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Child_xunZhangXS extends Sprite
   {
      
      public static const arr:Array = ["BG_KB","BG_SH","BG_SHJM"];
      
      public static const posArr:Array = [{
         "x":2,
         "y":127
      },{
         "x":1,
         "y":90
      },{
         "x":9,
         "y":57
      },{
         "x":28,
         "y":28
      },{
         "x":60,
         "y":7
      },{
         "x":102,
         "y":0
      },{
         "x":140,
         "y":7
      },{
         "x":171,
         "y":28
      },{
         "x":190,
         "y":57
      },{
         "x":198,
         "y":90
      },{
         "x":196,
         "y":127
      }];
      
      public static const JiaChenArr:Array = ["当前加成：","下级加成："];
      
      public static var idArr:Array = [41312,41301,41323];
      
      private var bmp:Bitmap;
      
      private var bmVec:Vector.<Bmp>;
      
      private var grid:View_Grid;
      
      private var tfVec:Vector.<MyTextField>;
      
      private var spriVec:Vector.<Sprite>;
      
      private var diaoKeBtn:Button;
      
      public var wicthNum:int;
      
      public var reLvel:int;
      
      public var xsId:int;
      
      public var gridId:int;
      
      public function Child_xunZhangXS()
      {
         var i:int;
         var p:Object = null;
         var spri:Sprite = null;
         var b:Bmp = null;
         var ss:String = null;
         this.bmVec = new Vector.<Bmp>();
         this.tfVec = new Vector.<MyTextField>();
         this.spriVec = new Vector.<Sprite>();
         super();
         ComponentUtil.getBitmap("BG_DiaoKe",this,{
            "x":3,
            "y":0
         },Global.XunZhangdm);
         i = 0;
         i = 0;
         while(i < posArr.length)
         {
            p = posArr[i];
            spri = new Sprite();
            addChild(spri);
            ComponentUtil.setPropertie(spri,p);
            this.spriVec.push(spri);
            b = new Bmp();
            spri.addChild(b);
            this.bmVec.push(b);
            i++;
         }
         this.bmp = ComponentUtil.getBitmap("BG_SH",this,{
            "x":25,
            "y":27
         },Global.XunZhangdm);
         i = 0;
         while(i < 2)
         {
            ss = JiaChenArr[i];
            this.tfVec.push(ComponentUtil.getTextField(ss,this,{
               "x":70,
               "y":131 + 20 * i,
               "color":327424,
               "size":12,
               "leading":5
            }));
            i++;
         }
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,false,true);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":95,
            "y":173
         });
         this.diaoKeBtn = ComponentUtil.getButton("雕 刻","Button_DiaoKe",this,{
            "x":70,
            "y":212,
            "textColor":16771436,
            "callBack":function():void
            {
               XunZhangCGMessage.CG_XUNZHANG_DIAOKE(wicthNum + 1,reLvel,13);
            }
         },Global.XunZhangdm);
      }
      
      public function update() : void
      {
         var b:Bmp = null;
         this.reset();
         var _vo:Vo_equip = Model_role.xunZhangVo as Vo_equip;
         if(!_vo)
         {
            return;
         }
         var kB:int = _vo.kangBao;
         var bsJC:int = _vo.baoShangJC;
         var bsJM:int = _vo.baoShangJM;
         var _data:Array = [kB,bsJC,bsJM];
         var _id:int = int(idArr[this.wicthNum]);
         var _typeD:int = int(_data[this.wicthNum]);
         var voI:Vo_item = new Vo_item();
         if(_typeD >= 11)
         {
            voI.id = _id + 10;
            voI.Init_lib();
            voI.count = 1;
            this.grid.vo = voI;
         }
         else
         {
            voI.id = _id + _typeD;
            voI.Init_lib();
            voI.count = 1;
            this.grid.vo = voI;
         }
         this.countOwn(this.grid.vo.id);
         var _perS:String = "";
         if(this.wicthNum == 0)
         {
            _perS = "";
         }
         else
         {
            _perS = "%";
         }
         if(_typeD == 0)
         {
            this.tfVec[0].htmlText = JiaChenArr[0] + "+0" + _perS + "";
            this.tfVec[1].htmlText = HtmlUtil.font(JiaChenArr[1] + "+" + int(Data_lib.xingshiAtt[0 + 1][this.wicthNum] * 100) + "" + _perS + "","#f9ff00");
         }
         else if(_typeD < 11)
         {
            this.tfVec[0].htmlText = JiaChenArr[0] + "+" + int(Data_lib.xingshiAtt[_typeD][this.wicthNum] * 100) + "" + _perS + "";
            this.tfVec[1].htmlText = HtmlUtil.font(JiaChenArr[1] + "+" + int(Data_lib.xingshiAtt[_typeD + 1][this.wicthNum] * 100) + "" + _perS + "","#f9ff00");
         }
         else
         {
            this.setBtn(false);
            this.tfVec[0].htmlText = JiaChenArr[0] + "+" + int(Data_lib.xingshiAtt[_typeD][this.wicthNum] * 100) + "" + _perS + "";
            this.tfVec[1].htmlText = JiaChenArr[1] + "" + HtmlUtil.font("(满)","#fe0000");
         }
         this.reLvel = _typeD + 1;
         this.xsId = this.grid.vo.id;
         this.gridId = this.grid.vo.gridId;
         var i:int = 0;
         while(i < _typeD)
         {
            b = this.bmVec[i];
            b.isFull = true;
            b.bitmapData = ComponentUtil.getBitmapData("StartFull_Y",Global.Img_Cdm);
            i++;
         }
         this.updateBind();
      }
      
      private function updateBind() : void
      {
         var sss:String = null;
         var i:int = 0;
         var b:Bmp = null;
         var _vo:Vo_equip = Model_role.xunZhangVo as Vo_equip;
         var bsJC:int = _vo.baoShangJC;
         var kB:int = _vo.kangBao;
         var bsJM:int = _vo.baoShangJM;
         var _data:Array = [kB,bsJC,bsJM];
         var _typeD:int = int(_data[this.wicthNum]);
         var ss:String = "";
         if(this.wicthNum == 0)
         {
            ss = "";
         }
         else
         {
            ss = "%";
         }
         if(_typeD > 0)
         {
            sss = XunZhangXS.strArr[i] + "+" + int(Data_lib.xingshiAtt[_typeD][this.wicthNum] * 100) + "" + ss + "";
         }
         i = 0;
         while(i < this.spriVec.length)
         {
            b = this.bmVec[i];
            if(b.isFull)
            {
               TipManager.bind(this.spriVec[i],sss);
            }
            else
            {
               TipManager.unBind(this.spriVec[i]);
            }
            i++;
         }
      }
      
      private function reset() : void
      {
         var b:Bmp = null;
         var i:int = 0;
         while(i < this.bmVec.length)
         {
            b = this.bmVec[i];
            b.isFull = false;
            b.bitmapData = ComponentUtil.getBitmapData("StartEmpty_Y",Global.Img_Cdm);
            i++;
         }
      }
      
      public function countOwn(_id:int) : void
      {
         var count:int = CommandManager.get_bag_count(_id);
         if(count == 0)
         {
            this.grid.filters = Util.disabled;
            this.setBtn(false);
         }
         else
         {
            this.grid.filters = [];
            this.setBtn(true);
         }
      }
      
      private function setBtn(value:Boolean) : void
      {
         this.diaoKeBtn.enabled = value;
      }
      
      public function initType(_type:int) : void
      {
         this.wicthNum = _type;
         this.bmp.bitmapData = ComponentUtil.getBitmapData(arr[this.wicthNum],Global.XunZhangdm);
      }
   }
}

import flash.display.Bitmap;

class Bmp extends Bitmap
{
   
   public var isFull:Boolean = false;
   
   public function Bmp()
   {
      super();
   }
}
