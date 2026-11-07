package com.yiTian.view.modules.Card
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_cardTotalAttribute_Tips extends View_tip
   {
      
      private var txtArr:Array = [];
      
      public function View_cardTotalAttribute_Tips()
      {
         super();
         this.Init();
      }
      
      override public function Init() : void
      {
         addBorder();
         ComponentUtil.getTextField("卡牌附加属性",this,{
            "x":10,
            "y":5,
            "color":16383744
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_cardTotalAttribute = null;
         var t_width:int = 0;
         var t_width1:int = 0;
         var i:* = undefined;
         var k:* = undefined;
         var j:* = undefined;
         if(obj is Vo_cardTotalAttribute)
         {
            vo = obj as Vo_cardTotalAttribute;
            t_width = 0;
            t_width1 = 0;
            for(i in vo.attributeArr)
            {
               if(this.txtArr[i] == null)
               {
                  this.txtArr[i] = [];
                  this.txtArr[i].push(ComponentUtil.getTextField("",this,{
                     "x":10,
                     "y":25 + i * 15,
                     "color":327424
                  }));
                  this.txtArr[i].push(ComponentUtil.getTextField("",this,{
                     "x":90,
                     "y":25 + i * 15,
                     "color":327424
                  }));
                  this.txtArr[i].push(ComponentUtil.getTextField("",this,{
                     "x":90,
                     "y":25 + i * 15,
                     "color":327424
                  }));
               }
               (this.txtArr[i][0] as MyTextField).htmlText = HtmlUtil.fontNoSize(Data_lib.attribute[vo.attributeArr[i][0]][0] + "：",ColorConstant.getColorStr(ColorConstant.BLUE)) + HtmlUtil.fontNoSize(vo.attributeArr[i][1] + "‰",ColorConstant.getColorStr(ColorConstant.GREEN));
               (this.txtArr[i][1] as MyTextField).htmlText = HtmlUtil.fontNoSize("【" + Data_lib.attribute[vo.attributeArr[i][0]][0] + "+" + vo.attributeArr[i][2],ColorConstant.getColorStr(ColorConstant.GREEN));
               (this.txtArr[i][2] as MyTextField).htmlText = HtmlUtil.fontNoSize("】",ColorConstant.getColorStr(ColorConstant.GREEN));
               if(this.txtArr[i][0].width > t_width)
               {
                  t_width = this.txtArr[i][0].width + this.txtArr[i][0].x;
               }
               if(this.txtArr[i][1].width > t_width1)
               {
                  t_width1 = int(this.txtArr[i][1].width);
               }
               if(i == vo.attributeArr.length - 1)
               {
                  border.height = this.txtArr[i][0].y + this.txtArr[i][0].height + 5;
               }
            }
            for(k in vo.attributeArr)
            {
               (this.txtArr[k][1] as MyTextField).x = t_width;
            }
            for(j in vo.attributeArr)
            {
               (this.txtArr[j][2] as MyTextField).x = t_width + t_width1;
            }
            border.width = t_width + t_width1 + 25;
         }
      }
   }
}

