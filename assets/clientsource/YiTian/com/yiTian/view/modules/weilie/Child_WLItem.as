package com.yiTian.view.modules.weilie
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_WeiLie;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Sprite;
   
   public class Child_WLItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var nameTF:MyTextField;
      
      private var vtf:MyTextField;
      
      private var toolTF:MyTextField;
      
      public function Child_WLItem()
      {
         super();
         this.nameTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":0,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.vtf = ComponentUtil.getTextField("射猎获得：",this,{
            "x":80,
            "y":0,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.toolTF = ComponentUtil.getTextField("",this,{
            "x":140,
            "y":0,
            "color":16772287,
            "size":12,
            "leading":0
         });
      }
      
      public static function getTF() : Child_WLItem
      {
         return Boolean(pool.length) ? pool.pop() : new Child_WLItem();
      }
      
      public function setdata(vo:Vo_WeiLie, title:String = "Title_QXWL") : void
      {
         this.nameTF.htmlText = HtmlUtil.font(vo.roleName,Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(vo.job)]);
         var toolVO:Vo_item = new Vo_item();
         var id:int = int(Model_WeiLie.ins(title)._lib[vo.index][0].split("_")[1]);
         var count:int = int(Model_WeiLie.ins(title)._lib[vo.index][0].split("_")[2]);
         toolVO.id = id;
         toolVO.Init_lib();
         this.toolTF.htmlText = Enum_BroadCastTool.instance.getColorStr(toolVO.str_name,toolVO.color) + "*" + count;
      }
      
      public function dispose() : void
      {
         this.nameTF.text = "";
         this.toolTF.text = "";
         this.parent.removeChild(this);
         pool.push(this);
      }
   }
}

