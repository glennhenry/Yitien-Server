package com.yiTian.view.modules.actions.qifu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class Model_qifu
   {
      
      private static var _btnQiFuArr:Array;
      
      private static var _tfQiFuArr:Array;
      
      private static var point:Point;
      
      public static const START_LEN:int = 5;
      
      public static var posArr:Array = [{
         "x":60,
         "y":83
      },{
         "x":128,
         "y":83
      },{
         "x":196,
         "y":83
      },{
         "x":264,
         "y":83
      },{
         "x":332,
         "y":83
      },{
         "x":332,
         "y":139
      },{
         "x":332,
         "y":195
      },{
         "x":332,
         "y":251
      },{
         "x":332,
         "y":307
      },{
         "x":264,
         "y":307
      },{
         "x":196,
         "y":307
      },{
         "x":128,
         "y":307
      },{
         "x":60,
         "y":307
      },{
         "x":60,
         "y":251
      },{
         "x":60,
         "y":195
      },{
         "x":60,
         "y":139
      }];
      
      public static var dataArr:Array = [HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("恭喜您获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00")];
      
      public static var GGdataArr:Array = [HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00")
      ,HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00"),HtmlUtil.font("玩家名字六个","#16776960") + HtmlUtil.font("获得","#999999") + HtmlUtil.font("物品名字六个*999","#04ff00")];
      
      private static var pool:Array = [];
      
      public function Model_qifu()
      {
         super();
      }
      
      public static function btnQiFuArr(_index:int) : String
      {
         if(!_btnQiFuArr)
         {
            _btnQiFuArr = ["祈福1次","祈福10次","祈福50次"];
         }
         return _btnQiFuArr[_index];
      }
      
      public static function tfQiFuArr(_index:int) : String
      {
         if(!_tfQiFuArr)
         {
            _tfQiFuArr = ["【20元宝】","【190元宝】","【900元宝】"];
         }
         return _tfQiFuArr[_index];
      }
      
      public static function addMes(str:String, _point:Point) : void
      {
         var _t:MyTextField = tf;
         _t.htmlText = str;
         point = _point;
         GameScene.upUILayer.addChild(_t);
         ComponentUtil.setPropertie(_t,{
            "x":point.x,
            "y":point.y
         });
         start(_t);
      }
      
      private static function start(__t:MyTextField) : void
      {
         Tween.to(__t,1000,{"y":[__t.y,__t.y - 40]},function(_target:MyTextField):void
         {
            var num:int = int(setTimeout(function():void
            {
               Tween.to(_target,400,{"y":[_target.y,_target.y - 40]},function(tt:MyTextField):void
               {
                  remove(_target);
               });
            },200));
         });
      }
      
      private static function get tf() : MyTextField
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return ComponentUtil.getTextField("",null,{
            "color":16383744,
            "size":14
         });
      }
      
      private static function remove(_tf:MyTextField) : void
      {
         if(Boolean(_tf.parent))
         {
            _tf.parent.removeChild(_tf);
         }
         pool.push(_tf);
      }
   }
}

