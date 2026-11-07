package com.yiTian.view.modules.treeDownCL
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   
   public class Child_itemCount extends SmallPan
   {
      
      private var tf:MyTextField;
      
      private var count:int;
      
      public function Child_itemCount()
      {
         super();
         regSource("DaShu_Imgsdm","DaShu_Imgs");
      }
      
      public static function get instance() : Child_itemCount
      {
         return Singleton.getInstance(Child_itemCount);
      }
      
      override protected function initSource() : void
      {
         ComponentUtil.getBitmap("Back_BeginTime",this,{
            "x":0,
            "y":0
         },Global.DaShu_Imgsdm);
         this.tf = ComponentUtil.getTextField("60",this,{
            "x":206,
            "y":14,
            "size":22,
            "color":16383744
         });
      }
      
      public function update(cnt:int) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.count = cnt;
         if(Boolean(this.tf))
         {
            this.tf.text = cnt.toString();
         }
         super.init(this.count,function(count:int):void
         {
            if(alpha == 0)
            {
               alpha = 1;
            }
            tf.text = count.toString();
            CountTfManager.add(tf,count - 1,false,function(_count:int):void
            {
               if(_count <= 0)
               {
                  visible = false;
                  Answers.instance.generatAns();
               }
            });
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            Tween.to(this,300,{"alpha":[1,0]},this.hide);
         }
         else
         {
            ComponentUtil.setPropertie(this,{"y":(Global.stage.stageHeight - 60) / 2 - 400});
            Tween.to(this,300,{"y":[this.y,this.y + 200]});
            super.visible = value;
         }
      }
      
      public function hide() : void
      {
         super.visible = false;
         CountTfManager.remove(this.tf);
      }
      
      override protected function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 300) / 2;
         y = (Global.stage.stageHeight - 60) / 2 - 200;
      }
   }
}

