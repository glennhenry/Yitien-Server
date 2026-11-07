package com.yiTian.view.modules.xunZhang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class XunZhangXS extends Sprite
   {
      
      public static const strArr:Array = ["增加对自身抵抗暴伤:","增加对玩家伤害加成:","增加对自身伤害减免:"];
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var xunZhangXSVec:Vector.<Child_xunZhangXS> = new Vector.<Child_xunZhangXS>();
      
      private var g:View_Grid;
      
      public function XunZhangXS()
      {
         var s:String = null;
         var childXS:Child_xunZhangXS = null;
         var pro:Object = null;
         super();
         ComponentUtil.getBitmap("BG_Black",this,{
            "x":299,
            "y":318
         },Global.XunZhangdm);
         ComponentUtil.getScaleBitmap("Back_WYBianQiang",[3,2,1,1],this,{
            "x":261,
            "y":395,
            "width":161,
            "height":70
         },Global.XunZhangdm);
         var i:int = 0;
         i = 0;
         while(i < 3)
         {
            s = strArr[i];
            this.tfVec.push(ComponentUtil.getTextField(s,this,{
               "x":275,
               "y":401 + i * 20,
               "color":14013822,
               "size":12,
               "leading":5
            }));
            i++;
         }
         var spri:Sprite = new Sprite();
         addChild(spri);
         ComponentUtil.setPropertie(spri,{
            "x":307,
            "y":325
         });
         this.g = new View_Grid(true);
         this.g.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.g.set_bmp_over(true,null);
         this.g.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.g.bmpBacKShow = false;
         spri.addChild(this.g);
         ComponentUtil.setPropertie(this.g,{
            "x":0,
            "y":0
         });
         i = 0;
         while(i < 3)
         {
            childXS = new Child_xunZhangXS();
            addChild(childXS);
            childXS.initType(i);
            pro = XunZhangMter.property[i];
            ComponentUtil.setPropertie(childXS,pro);
            this.xunZhangXSVec.push(childXS);
            i++;
         }
      }
      
      public function update() : void
      {
         var item:Child_xunZhangXS = null;
         var _vo:Vo_equip = null;
         var bsJC:int = 0;
         var kB:int = 0;
         var bsJM:int = 0;
         var _data:Array = null;
         var ss:String = null;
         var i:int = 0;
         var _typeD:int = 0;
         if(Boolean(Model_role.xunZhangVo))
         {
            _vo = Model_role.xunZhangVo as Vo_equip;
            bsJC = _vo.baoShangJC;
            kB = _vo.kangBao;
            bsJM = _vo.baoShangJM;
            _data = [kB,bsJC,bsJM];
            this.g.vo = _vo;
            ss = "";
            i = 0;
            while(i < _data.length)
            {
               _typeD = int(_data[i]);
               if(i == 0)
               {
                  ss = "";
               }
               else
               {
                  ss = "%";
               }
               if(_typeD == 0)
               {
                  this.tfVec[i].htmlText = strArr[i] + "+0" + ss + "";
               }
               else
               {
                  this.tfVec[i].htmlText = strArr[i] + "+" + int(Data_lib.xingshiAtt[_typeD][i] * 100) + "" + ss + "";
               }
               i++;
            }
         }
         else
         {
            this.tfVec[0].htmlText = strArr[0] + "+0";
            this.tfVec[1].htmlText = strArr[1] + "+0%";
            this.tfVec[2].htmlText = strArr[2] + "+0%";
         }
         for each(item in this.xunZhangXSVec)
         {
            item.update();
         }
      }
   }
}

