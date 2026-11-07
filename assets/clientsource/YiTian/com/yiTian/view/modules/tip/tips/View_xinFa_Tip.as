package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.tianTi.Enum_ZhangMenRen;
   import com.yiTian.view.modules.tianTi.Vo_xinFa;
   import flash.utils.Dictionary;
   
   public class View_xinFa_Tip extends View_tip
   {
      
      private var tf_name:MyTextField;
      
      private var tf_lv:MyTextField;
      
      private var tf_exp:MyTextField;
      
      private var tf_curDescript:MyTextField;
      
      private var tf_nxtDescript:MyTextField;
      
      private var c1:String = "#d5d57e";
      
      private var c2:String = "#ffff00";
      
      private var c3:String = "#aabb00";
      
      public function View_xinFa_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":4,
            "bold":true,
            "color":16776960
         });
         this.tf_lv = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":24
         });
         this.tf_exp = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":42
         });
         this.tf_curDescript = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":60
         });
         this.tf_nxtDescript = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":80
         });
      }
      
      override public function Show(obj:Object, _type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_xinFa = null;
         var ids:int = 0;
         var datalib:DictionaryTabel = null;
         var curArr:Array = null;
         var name:String = null;
         var lv:int = 0;
         var curExp:int = 0;
         var countExp:int = 0;
         var curDescript:String = null;
         var nxtDescript:String = null;
         var s:int = 0;
         var abDic:Dictionary = null;
         var tmp:String = null;
         var mxWidth:Number = NaN;
         var type:int = 0;
         var num:Number = NaN;
         var nxtArr:Array = null;
         var type2:int = 0;
         var num2:Number = NaN;
         if(_type == 1)
         {
            vo = obj as Vo_xinFa;
            ids = Enum_ZhangMenRen.findXinID(vo.type,vo.lv);
            datalib = vo.isGod ? Data_lib.xinfakuozhan : Data_lib.xinfa;
            curArr = datalib[ids];
            name = Enum_ZhangMenRen.xinFaNames[vo.type - 1];
            lv = vo.lv;
            curExp = vo.exp;
            countExp = int(curArr[1]);
            curDescript = "";
            nxtDescript = "";
            this.tf_name.text = name;
            this.tf_lv.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("29147",2),this.c1) + HtmlUtil.fontNoSize(lv.toString(),this.c2);
            this.tf_exp.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("29148",2),this.c1) + HtmlUtil.fontNoSize(curExp.toString() + "/" + countExp.toString(),this.c2);
            curDescript = HtmlUtil.fontNoSize(LangConfig.getWord("29149",2),this.c1) + "\n";
            abDic = Data_lib.attribute;
            s = 2;
            while(s < curArr.length)
            {
               type = int(curArr[s]);
               num = Number(curArr[s + 1]);
               tmp = abDic[type][0] + "+" + num.toString();
               if(type == 30)
               {
                  tmp += "%";
               }
               curDescript += HtmlUtil.font(tmp,this.c3);
               if(s <= curArr.length - 2)
               {
                  curDescript += "\n";
               }
               s += 2;
            }
            if(lv == 100 || lv == 150)
            {
               nxtDescript = HtmlUtil.font(LangConfig.getWord("29151",2),this.c3);
            }
            else
            {
               tmp = "";
               nxtDescript = HtmlUtil.font(LangConfig.getWord("29150",2),this.c1) + "\n";
               nxtArr = datalib[Enum_ZhangMenRen.findXinID(vo.type,vo.lv + 1)];
               s = 2;
               while(s < nxtArr.length)
               {
                  type2 = int(nxtArr[s]);
                  num2 = Number(nxtArr[s + 1]);
                  tmp = abDic[type2][0] + "+" + num2.toString();
                  if(type == 30)
                  {
                     tmp += "%";
                  }
                  nxtDescript += HtmlUtil.font(tmp,this.c3);
                  if(s <= nxtArr.length - 2)
                  {
                     nxtDescript += "\n";
                  }
                  s += 2;
               }
            }
            this.tf_curDescript.htmlText = curDescript;
            this.tf_nxtDescript.y = this.tf_curDescript.height + this.tf_curDescript.y + 10;
            this.tf_nxtDescript.htmlText = nxtDescript;
            mxWidth = Math.max(this.tf_lv.width,this.tf_exp.width,this.tf_curDescript.width,this.tf_nxtDescript.width);
            border.width = mxWidth + 8;
            border.height = this.tf_nxtDescript.y + this.tf_nxtDescript.height + 4;
         }
      }
   }
}

