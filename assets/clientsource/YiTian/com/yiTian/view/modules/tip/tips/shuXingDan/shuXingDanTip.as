package com.yiTian.view.modules.tip.tips.shuXingDan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class shuXingDanTip extends View_tip
   {
      
      private var tfTitle:MyTextField;
      
      private var atbs:MyTextField;
      
      private var counts:MyTextField;
      
      private var tf:MyTextField;
      
      private var stbsArr:Array = [];
      
      private var countsArr:Array = [];
      
      public function shuXingDanTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tfTitle = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":10,
            "size":14,
            "color":14566855
         });
         ComponentUtil.getTextField("【获得属性】",this,{
            "x":10,
            "y":40,
            "size":12
         });
         this.tf = ComponentUtil.getTextField("【已使用属性丹】",this,{
            "x":10,
            "size":12
         });
         this.tfTitle.htmlText = "<b>属性丹使用效果</b>";
         this.atbs = ComponentUtil.getTextField("",this,{"x":10});
         this.counts = ComponentUtil.getTextField("",this,{"x":10});
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var j:int = 0;
         var i:int = 0;
         var shuXing:String = null;
         var str:String = null;
         var _str:String = null;
         var ss:String = null;
         var id:int = 0;
         var valu:int = 0;
         var max:int = 0;
         var key:int = 0;
         var _arr:Array = null;
         var vo:Vo_shuXingDan = obj as Vo_shuXingDan;
         var arr:Array = [" 基础攻击"," 基础防御"," 基础气血"," 攻速      "];
         this.stbsArr.splice(0);
         this.countsArr.splice(0);
         if(vo.atbs.length != 0)
         {
            i = 0;
            while(i < vo.atbs.length)
            {
               shuXing = arr[vo.atbs[i][0]];
               str = "<font color=\'#04ff00\'>" + arr[i] + "</font>" + "<font color=\'#F9FF00\'>  + " + vo.atbs[i][1] + "%</font>";
               if(i == 3)
               {
                  str = "<font color=\'#04ff00\'>" + arr[i] + "</font>" + "<font color=\'#F9FF00\'>  + " + vo.atbs[i][1] + "</font>";
               }
               this.stbsArr.push(str);
               i++;
            }
         }
         else if(vo.atbs.length == 0)
         {
            j = 0;
            while(j < arr.length)
            {
               _str = "<font color=\'#04ff00\'>" + arr[j] + "</font>" + "<font color=\'#F9FF00\'>  + " + 0 + "%</font>";
               if(j == 3)
               {
                  _str = "<font color=\'#04ff00\'>" + arr[j] + "</font>" + "<font color=\'#F9FF00\'>  + " + 0 + "</font>";
               }
               this.stbsArr.push(_str);
               j++;
            }
         }
         this.atbs.htmlText = this.stbsArr.join("\n");
         this.atbs.y = 55;
         this.tf.y = this.atbs.y + this.atbs.height + 3;
         this.counts.y = this.tf.y + this.tf.height;
         var dic:DictionaryTabel = Data_lib.shuXingDan;
         var len:int = int(dic.getLength());
         var dataArr:Array = [];
         j = 0;
         while(j < len)
         {
            ss = this.getStr(dic[j + 1][0],0,dic[j + 1][2]);
            this.countsArr.push([dic[j + 1][1],dic[j + 1][0],ss]);
            j++;
         }
         j = 0;
         while(j < vo.count.length)
         {
            id = int(vo.count[j][0]);
            valu = int(vo.count[j][1]);
            max = int(vo.count[j][2]);
            key = 0;
            while(key < this.countsArr.length)
            {
               _arr = this.countsArr[key];
               if(id == this.countsArr[key][0])
               {
                  this.countsArr[key][2] = this.getStr(_arr[1],valu,max);
               }
               key++;
            }
            j++;
         }
         j = 0;
         while(j < this.countsArr.length)
         {
            dataArr.push(this.countsArr[j][2]);
            j++;
         }
         this.counts.htmlText = dataArr.join("\n");
         border.width = Math.max(this.atbs.x + this.atbs.textWidth,this.counts.x + this.counts.textWidth,this.tfTitle.x + this.tfTitle.textWidth) + 10;
         border.height = this.counts.y + this.counts.height + 10;
      }
      
      private function getStr(name:String, value:int, max:int) : String
      {
         return "<font color=\'#04ff00\'> " + name + "</font>" + "<font color=\'#F9FF00\'>  " + value + "/" + max + "</font>";
      }
   }
}

