package com.yiTian.view.modules.tip.tips.xunZhang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tip.tips.View_tip;
   import flash.display.Bitmap;
   
   public class View_xunZhangTip extends View_tip
   {
      
      private static var kongGe1:String = "  ";
      
      private static var kongGe2:String = "               ";
      
      private static var kongGe3:String = "         ";
      
      private static var kongGe4:String = "       ";
      
      private static const strArr:Array = ["增加对自身抵抗暴伤","增加对玩家伤害加成","增加对自身伤害减免"];
      
      private var tfDescrip:MyTextField;
      
      private var grid:View_Grid;
      
      private var bmpVec:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var g:View_Grid;
      
      public function View_xunZhangTip()
      {
         super();
      }
      
      public function getBmp() : Bitmap
      {
         return new Bitmap();
      }
      
      override public function Init() : void
      {
         var b:Bitmap = null;
         addBorder();
         this.grid = new View_Grid();
         this.grid.bmpBacKShow = false;
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":15,
            "y":23
         });
         var i:int = 0;
         while(i < 3)
         {
            b = this.getBmp();
            addChild(b);
            this.bmpVec.push(b);
            ComponentUtil.setPropertie(b,{
               "x":12,
               "y":158 + 18 * i
            });
            i++;
         }
         border.y = -2;
         this.tfDescrip = ComponentUtil.getTextField("",this,{
            "multiline":true,
            "wordWrap":true,
            "leading":5,
            "realWidth":237,
            "color":11527396
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var _vo:Vo_equip = null;
         var name:String = null;
         var str:String = null;
         var _lvl:int = 0;
         var ___ss:String = null;
         var ___arr:Array = null;
         var _dataArr:Array = null;
         var i:int = 0;
         var bsJC:int = 0;
         var kB:int = 0;
         var bsJM:int = 0;
         var _dArr:Array = null;
         var sName:String = null;
         var chengWeiXuqiu:String = null;
         var xingShiShangXian:String = null;
         var basicAtr:String = null;
         var specialAtr:String = null;
         var prStr:String = null;
         var _a:Array = null;
         var _data:int = 0;
         var _sd:String = null;
         var _perS:String = null;
         if(obj is Vo_equip)
         {
            _vo = obj as Vo_equip;
            name = _vo.str_name;
            this.grid.vo = _vo;
            str = _vo.str_help;
            _lvl = int(_vo.str_describe);
            ___ss = Data_lib.equip[_vo.id][6];
            ___arr = ___ss.split(",");
            _dataArr = [];
            i = 0;
            while(i < ___arr.length)
            {
               _a = ___arr[i].split("_");
               _dataArr.push(_a[1]);
               i++;
            }
            bsJC = _vo.baoShangJC;
            kB = _vo.kangBao;
            bsJM = _vo.baoShangJM;
            _dArr = [kB,bsJC,bsJM];
            this.handle(_dArr);
            sName = kongGe1 + HtmlUtil.font(_vo.str_name + "\n",Model_shop.get_color_arr[_vo.color - 1],14);
            chengWeiXuqiu = kongGe2 + "称谓需求：" + str + "\n";
            xingShiShangXian = kongGe2 + "星石上限：" + _lvl + "\n";
            basicAtr = kongGe1 + "基础属性：\n" + kongGe2 + HtmlUtil.font("气血","#04ff00") + HtmlUtil.font("+" + _dataArr[0],"#f9ff00") + "\n" + kongGe2 + HtmlUtil.font("攻击","#04ff00") + HtmlUtil.font("+" + _dataArr[1],"#f9ff00") + "\n" + kongGe2 + HtmlUtil.font("防御","#04ff00") + HtmlUtil.font("+" + _dataArr[2],"#f9ff00") + "\n";
            specialAtr = kongGe1 + "特殊属性：\n";
            i = 0;
            while(i < 3)
            {
               _data = int(_dArr[i]);
               _sd = strArr[i];
               _perS = "";
               if(i == 0)
               {
                  _perS = "";
               }
               else
               {
                  _perS = "%";
               }
               if(_data == 0)
               {
                  specialAtr += kongGe3 + "0级  " + _sd + HtmlUtil.font("+0" + _perS + "\n","#f9ff00");
               }
               else if(_data < 10)
               {
                  specialAtr += kongGe3 + _data + "级  " + _sd + HtmlUtil.font("+" + int(Data_lib.xingshiAtt[_data][i] * 100) + "" + _perS + "\n","#f9ff00");
               }
               else if(_data == 11)
               {
                  specialAtr += kongGe4 + _data + "级  " + _sd + HtmlUtil.font("+" + int(Data_lib.xingshiAtt[_data][i] * 100) + "" + _perS + "","#f9ff00") + HtmlUtil.font("(已满级)","#fe0000") + "\n";
               }
               else
               {
                  specialAtr += kongGe4 + _data + "级  " + _sd + HtmlUtil.font("+" + int(Data_lib.xingshiAtt[_data][i] * 100) + "" + _perS + "\n","#f9ff00");
               }
               i++;
            }
            prStr = kongGe1 + "出售给商店价格:1";
            this.tfDescrip.htmlText = sName + chengWeiXuqiu + xingShiShangXian + basicAtr + specialAtr + prStr;
            border.width = this.tfDescrip.textWidth + 9;
            border.height = this.tfDescrip.textHeight + 11;
         }
      }
      
      private function handle(_arr:Array) : void
      {
         var _da:int = 0;
         var b:Bitmap = null;
         var i:int = 0;
         while(i < _arr.length)
         {
            _da = int(_arr[i]);
            b = this.bmpVec[i];
            if(_da > 0)
            {
               b.bitmapData = ComponentUtil.getBitmapData("Ico_JiHuo",Global.Img_Cdm);
            }
            else
            {
               b.bitmapData = ComponentUtil.getBitmapData("Ico_JiHuo2",Global.Img_Cdm);
            }
            i++;
         }
      }
   }
}

