<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="http://cdn.oesmith.co.uk/morris-0.4.1.min.js"></script>

<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url(/pcms/public/ropo_app/img/statistics.png) center no-repeat;">
        </div>
    </div>
</div>

<div class="portlet light bordered">

	<!-- <div class="portlet-title">
	        <div class="caption font-dark">
	            <i class="icon-graph font-dark"></i>
	            <span class="caption-subject bold uppercase">الاحصائيات</span>
	        </div>  
	</div> -->

	<div class="portlet-body">
	    <div class="row">
	    	<div class="col-md-12 chart-lable">Events</div>
	    	<div class="col-md-12">
	    		<div id="line-example"></div>

                
                <script type="text/javascript">

                        Morris.Line({   
                          element: 'line-example',
                          data: [
                            { x: 'Jan', a: 31, b: 9 },
                            { x: 'Feb', a: 25,  b: 6 },
                            { x: 'Mars', a: 20,  b: 4 },
                            { x: 'April', a: 15,  b: 6 },
                            { x: 'May', a: 35,  b: 4 },
                            { x: 'June', a: 25,  b: 5 },
                            { x: 'July', a: 20, b: 8 },
                            { x: 'Aug', a: 31, b: 9 },
                            { x: 'Sept', a: 25,  b: 6 },
                            { x: 'Oct', a: 20,  b: 4 },
                            { x: 'Nov', a: 15,  b: 6 },
                            { x: 'Dec', a: 35,  b: 4 },
                          ],

                          parseTime: false,
                          xkey: 'x',
                          ykeys: ['a', 'b'],
                          labels: ['منجز', 'متأخر'],
                          pointFillColors:['#ffffff'],
					      pointStrokeColors: ['black'],
					      lineColors:['green','#E26A6A']
                        });
                    </script>
                    <!-- JAVASCRIPT CODE GOES HERE -->
                
	    	</div>
	    </div>

	    <div class="bg-dark btn-circle text-center gap" style="padding: 2px ; color: #fff;">
	        <div class="light">
	            احصائيات بالأرقام
	        </div>
	    </div>

	    <div class="row">
            <div class="col-xs-12">
                    <div class="row widget-row">
                    	<div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد المشروعات </h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-green-sharp fa icon-settings"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> مشروع </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد العملاء</h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-green-sharp fa icon-briefcase"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> عميل </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد الموظفين </h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-green-sharp fa icon-user"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> موظف </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد الايفنتات الكلي </h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-green-sharp fa icon-calendar"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> ايفنت </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading"> عدد الايفنتات المنجزة </h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-green-sharp fa icon-calendar"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> ايفنت </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد الايفنتات المؤجلة</h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-red-sunglo fa icon-calendar"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> ايفنت </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>

                        <div class="col-md-3 col-sm-6">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                                <h4 class="widget-thumb-heading">عدد الايفنتات المهملة</h4>

                                <div class="widget-thumb-wrap">
                                    <i class="widget-thumb-icon circle bg-red-sunglo fa icon-calendar"></i>

                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"> ايفنت </span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>


                    </div>
            </div> 
        </div>

	</div>




</div>