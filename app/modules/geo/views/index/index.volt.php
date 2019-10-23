
<div class="page-bar " style="position: relative">
	<ul class="page-breadcrumb">
		<li>
			<span>Geography </span>
		</li>
	</ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
	<div class="row">
		<div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
			<?php if ($settings->banner_image) { ?>
			<div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic($settings->banner_image) ?>) center center no-repeat ; background-size: contain"></div>
			<?php } else { ?>
			<div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geography.png') ?>) center center no-repeat ; background-size: contain"></div>
			<?php } ?>
		</div>
	</div>
</div>

    <!-- START widgets box-->
    <div class="portlet light bordered">
	  
	  <div class="portlet-body">

	  		<?php if ($settings->enable_continents) { ?>
	  		  <div class="panel-group accordion" id="accordion4">
	  			 <div class="panel panel-info">
	  				<div class="panel-heading">
	  				  <h4 class="panel-title">
	  					  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion4" href="#collapse_4">
	  						<i class="fa fa-globe" aria-hidden="true"></i> Continents <i class="fa fa-angle-down" aria-hidden="true"></i>
	  					  </a>
	  				  </h4>
	  				</div>
	  			  </div>
	  		 
	  			  <div id="collapse_4" class="panel-collapse collapse">
	  				<div class="panel-body">
	  					<div class="clearfix">
	  					  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

	  					  <div class="pull-right">
	  						  
	  						  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#continents"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
	  					  </div>
	  					</div>

	  					<!-- START table-responsive-->
	  					 <div class="table-responsive bordered gap">
	  						<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
	  						   <thead>
	  							 <tr>
	  								<!-- <th>
	  									<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
	  										<input type="checkbox" class="group-checkable"
	  											   data-set="#sample_1 .checkboxes"/>
	  										<span></span>
	  									</label>
	  								</th> -->
	  								<th style="width: 60px;">#</th>
	  								<th> Name </th>
	  								<th> Action </th>
	  							 </tr>
	  						   </thead>
	  						   <tbody>
	  						   	<?php $v80360698133360704331iterator = $continents; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $continent) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
	  							 <tr>
	  								<!-- <td>
	  								   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
	  									   <input type="checkbox" class="checkboxes" value="1"/>
	  									   <span></span>
	  								   </label>
	  								</td> -->
	  								<td><?= $v80360698133360704331loop->index ?></td>
	  								<td><?= $continent->getName() ?></td>
	  								<td> 

	  									<button class="btn btn-xs btn-success" data-target="#edit_continents_modal" data-toggle="modal" onclick="editContinent(<?= $continent->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

	  									<button class="btn btn-xs btn-danger" onclick="deletePlace(1, <?= $continent->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
	  								</td>   
	  							 </tr>
	  							 <?php $v80360698133360704331incr++; } ?>
	  						   </tbody>
	  						</table>
	  					 </div>
	  					 <!-- END table-responsive-->
	  				</div>
	  			  </div>
	  		  </div>
	  		<?php } ?>

	  		<?php if ($settings->enable_countries) { ?>
		  <div class="panel-group accordion" id="accordion1">
			 <div class="panel panel-info">
				<div class="panel-heading">
				  <h4 class="panel-title">
					  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_1">
						<i class="fa fa-globe" aria-hidden="true"></i> Countries <i class="fa fa-angle-down" aria-hidden="true"></i>
					  </a>
				  </h4>
				</div>
			  </div>
		 
			  <div id="collapse_1" class="panel-collapse collapse">
				<div class="panel-body">
					<div class="clearfix">
					  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

					  <div class="pull-right">
						  
						  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#countries"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
					  </div>
					</div>

					<!-- START table-responsive-->
					 <div class="table-responsive bordered gap">
						<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
						   <thead>
							 <tr>
								<!-- <th>
									<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
										<input type="checkbox" class="group-checkable"
											   data-set="#sample_1 .checkboxes"/>
										<span></span>
									</label>
								</th> -->
								<th style="width: 60px;">#</th>
								<th> Name </th>
								<?php if ($settings->enable_continents) { ?>
								<th> Continent</th>
								<?php } ?>
								<th> Action </th>
							 </tr>
						   </thead>
						   <tbody>
						   	<?php $v80360698133360704331iterator = $countries; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $country) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
							 <tr>
								<!-- <td>
								   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
									   <input type="checkbox" class="checkboxes" value="1"/>
									   <span></span>
								   </label>
								</td> -->
								<td><?= $v80360698133360704331loop->index ?></td>
								<td><?= $country->getName() ?></td>

								<?php if ($settings->enable_continents) { ?>
								<td>
									<?php if ($country->continent) { ?>
									<?= $country->continent->getName() ?>
									<?php } ?>
								</td>
								<?php } ?>
								<td> 

									<button class="btn btn-xs btn-success" data-toggle="modal" data-target="#edit_country_modal" onclick="editCountry(<?= $country->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

									<button class="btn btn-xs btn-danger" onclick="deletePlace(2, <?= $country->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
								</td>   
							 </tr>
							<?php $v80360698133360704331incr++; } ?>

						   </tbody>
						</table>
					 </div>
					 <!-- END table-responsive-->
				</div>
			  </div>
		  </div>
		    <?php } ?>

		    <?php if ($settings->enable_states) { ?>
		    <div class="panel-group accordion" id="accordion5">
		  	 <div class="panel panel-info">
		  		<div class="panel-heading">
		  		  <h4 class="panel-title">
		  			  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion5" href="#collapse_5">
		  				<i class="fa fa-globe" aria-hidden="true"></i> States <i class="fa fa-angle-down" aria-hidden="true"></i>
		  			  </a>
		  		  </h4>
		  		</div>
		  	  </div>
		   
		  	  <div id="collapse_5" class="panel-collapse collapse">
		  		<div class="panel-body">
		  			<div class="clearfix">
		  			  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

		  			  <div class="pull-right">
		  				  
		  				  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#states"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
		  			  </div>
		  			</div>

		  			<!-- START table-responsive-->
		  			 <div class="table-responsive bordered gap">
		  				<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
		  				   <thead>
		  					 <tr>
		  						<!-- <th>
		  							<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
		  								<input type="checkbox" class="group-checkable"
		  									   data-set="#sample_1 .checkboxes"/>
		  								<span></span>
		  							</label>
		  						</th> -->
		  						<th style="width: 60px;">#</th>
		  						<th> Name </th>
		  						<?php if ($settings->enable_countries) { ?>
		  						<th> Country</th>
		  						<?php } ?>
		  						<th> Action </th>
		  					 </tr>
		  				   </thead>
		  				   <tbody>
		  				   	<?php $v80360698133360704331iterator = $states; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $state) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
		  					 <tr>
		  						<!-- <td>
		  						   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
		  							   <input type="checkbox" class="checkboxes" value="1"/>
		  							   <span></span>
		  						   </label>
		  						 </td> -->
		  						<td><?= $v80360698133360704331loop->index ?></td>
		  						<td><?= $state->getName() ?></td>
		  						<?php if ($settings->enable_countries) { ?>
		  						<td>
		  							<?php if ($state->country) { ?>
		  							<?= $state->country->getName() ?>
		  							<?php } ?>
		  						</td>
		  						<?php } ?>
		  						<td> 

		  							<button class="btn btn-xs btn-success" data-toggle="modal" data-target="#edit_state_modal" onclick="editState(<?= $state->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

		  							<button class="btn btn-xs btn-danger" onclick="deletePlace(3, <?= $state->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
		  						</td>   
		  					 </tr>
		  					<?php $v80360698133360704331incr++; } ?>

		  				   </tbody>
		  				</table>
		  			 </div>
		  			 <!-- END table-responsive-->
		  		</div>
		  	  </div>
		    </div>
		    <?php } ?>

		    <?php if ($settings->enable_city) { ?>
		  <div class="panel-group accordion" id="accordion2">
			 <div class="panel panel-info">
				<div class="panel-heading">
				  <h4 class="panel-title">
					  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse_2">
						<i class="fa fa-map" aria-hidden="true"></i> Cities <i class="fa fa-angle-down" aria-hidden="true"></i>
					  </a>
				  </h4>
				</div>
			  </div>
		 
			  <div id="collapse_2" class="panel-collapse collapse">
				<div class="panel-body">
					<div class="clearfix">
					  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

					  <div class="pull-right">
						  
						  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#cities"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
					  </div>
					</div>

					<!-- START table-responsive-->
					 <div class="table-responsive bordered gap">
						<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
						   <thead>
							 <tr>
								<!-- <th>
									<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
										<input type="checkbox" class="group-checkable"
											   data-set="#sample_1 .checkboxes"/>
										<span></span>
									</label>
								</th> -->
								<th style="width: 60px;">#</th>
								<th> Name </th>
								<?php if ($settings->enable_states) { ?>
								<th> State </th>
								<?php } ?>
								<!-- <th> Continent</th> -->
								<th> Action </th>
							 </tr>
						   </thead>
						   <tbody>
						   <?php $v80360698133360704331iterator = $cities; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $city) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
							 <tr>
								<!-- <td>
								   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
									   <input type="checkbox" class="checkboxes" value="1"/>
									   <span></span>
								   </label>
								</td> -->
								<td><?= $v80360698133360704331loop->index ?></td>
								<td> <?= $city->getName() ?> </td>
								<?php if ($settings->enable_states) { ?>
								<td>
									<?php if ($city->state) { ?>
									<?= $city->state->getName() ?>
									<?php } ?>
								</td>
								<?php } ?>
								<!-- <td>Africa</td> -->
								<td> 

									<button class="btn btn-xs btn-success" data-target="#edit_city_modal" data-toggle="modal" onclick="editCity(<?= $city->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

									<button class="btn btn-xs btn-danger" onclick="deletePlace(4, <?= $city->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
								</td>   
							 </tr>
							<?php $v80360698133360704331incr++; } ?>
						   </tbody>
						</table>
					 </div>
					 <!-- END table-responsive-->
				</div>
			  </div>
		  </div> <!-- end Countries -->
		    <?php } ?>

		    <?php if ($settings->enable_regions) { ?>
		  <div class="panel-group accordion" id="accordion3">
			 <div class="panel panel-info">
				<div class="panel-heading">
				  <h4 class="panel-title">
					  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#collapse_3">
						<i class="fa fa-map" aria-hidden="true"></i> Regions <i class="fa fa-angle-down" aria-hidden="true"></i>
					  </a>
				  </h4>
				</div>
			  </div>
		 
			  <div id="collapse_3" class="panel-collapse collapse">
				<div class="panel-body">
					<div class="clearfix">
					  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

					  <div class="pull-right">
						  
						  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#regions"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
					  </div>
					</div>

					<!-- START table-responsive-->
					 <div class="table-responsive bordered gap">
						<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
						   <thead>
							 <tr>
								<!-- <th>
									<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
										<input type="checkbox" class="group-checkable"
											   data-set="#sample_1 .checkboxes"/>
										<span></span>
									</label>
								</th> -->
								<th style="width: 60px;">#</th>
								<th> Name </th>
								<?php if ($settings->enable_city) { ?>
								<th> City </th>
								<?php } ?>
								<!-- <th> City</th> -->
								<th> Action </th>
							 </tr>
						   </thead>
						   <tbody>
						    <?php $v80360698133360704331iterator = $regions; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $region) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
							 <tr>
								<!-- <td>
								   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
									   <input type="checkbox" class="checkboxes" value="1"/>
									   <span></span>
								   </label>
								</td> -->
								<td><?= $v80360698133360704331loop->index ?></td>
								<td> <?= $region->getName() ?> </td>
								<?php if ($settings->enable_city) { ?>
								<td>
									<?php if ($region->city) { ?>
									<?= $region->city->getName() ?>
									<?php } ?>
								</td>
								<?php } ?>
								<!-- <td>Africa</td> -->
								<td> 
									<!-- <button class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </button> -->

									<button class="btn btn-xs btn-success" data-toggle="modal" data-target="#edit_region_modal" onclick="editRegion(<?= $region->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

									<button class="btn btn-xs btn-danger" onclick="deletePlace(5, <?= $region->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
								</td>   
							 </tr>
							 <?php $v80360698133360704331incr++; } ?>

						   </tbody>
						</table>
					 </div>
					 <!-- END table-responsive-->
				</div>
			  </div>
		  </div> <!-- end Countries -->
		    <?php } ?>

		    <?php if ($settings->enable_streets) { ?>
		    <div class="panel-group accordion" id="accordion6">
		  	 <div class="panel panel-info">
		  		<div class="panel-heading">
		  		  <h4 class="panel-title">
		  			  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion6" href="#collapse_6">
		  				<i class="fa fa-globe" aria-hidden="true"></i> Streets <i class="fa fa-angle-down" aria-hidden="true"></i>
		  			  </a>
		  		  </h4>
		  		</div>
		  	  </div>
		   
		  	  <div id="collapse_6" class="panel-collapse collapse">
		  		<div class="panel-body">
		  			<div class="clearfix">
		  			  <h4 class="text-info bold pull-left"> <i class="fa fa-table" aria-hidden="true"></i> Records: </h4>

		  			  <div class="pull-right">
		  				  
		  				  <button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#streets"><i class="fa fa-plus" aria-hidden="true"></i> Add New</button>
		  			  </div>
		  			</div>

		  			<!-- START table-responsive-->
		  			 <div class="table-responsive bordered gap">
		  				<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
		  				   <thead>
		  					 <tr>
		  						<!-- <th>
		  							<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
		  								<input type="checkbox" class="group-checkable"
		  									   data-set="#sample_1 .checkboxes"/>
		  								<span></span>
		  							</label>
		  						</th> -->
		  						<th style="width: 60px;">#</th>
		  						<th> Name </th>
		  						<?php if ($settings->enable_regions) { ?>
		  						<th> Region</th>
		  						<?php } ?>
		  						<th> Action </th>
		  					 </tr>
		  				   </thead>
		  				   <tbody>
		  				   	<?php $v80360698133360704331iterator = $streets; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $street) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
		  					 <tr>
		  						<!-- <td>
		  						   <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
		  							   <input type="checkbox" class="checkboxes" value="1"/>
		  							   <span></span>
		  						   </label>
		  						</td> -->
		  						<td><?= $v80360698133360704331loop->index ?></td>
		  						<td><?= $street->getName() ?></td>
		  						<?php if ($settings->enable_regions) { ?>
		  						<td>
			  						<?php if ($street->region) { ?>
			  						<?= $street->region->getName() ?>
			  						<?php } ?>
		  						</td>
		  						<?php } ?>
		  						<td> 

		  							<button class="btn btn-xs btn-success" data-target="#edit_street_modal" data-toggle="modal" onclick="editStreet(<?= $street->id ?>)"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

		  							<button class="btn btn-xs btn-danger" onclick="deletePlace(6, <?= $street->id ?>)"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
		  						</td>   
		  					 </tr>
		  					<?php $v80360698133360704331incr++; } ?>
		  				   </tbody>
		  				</table>
		  			 </div>
		  			 <!-- END table-responsive-->
		  		</div>
		  	  </div>
		    </div>
		    <?php } ?>

		  </div>
	  </div>

   </div>
   <!-- END widgets box-->

<?php if ($settings->enable_continents) { ?>
<div id="continents" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
		  	<?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="1">
			 <fieldset>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Continent Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
					  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  <li class="
						  <?php if ($v80360698133360704331loop->first) { ?>
						  active
						  <?php } ?>
						  ">
							  <a href="#continent_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  </li>
						<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  <div class="tab-pane
						  <?php if ($v80360698133360704331loop->first) { ?>
						  active
						  <?php } ?>
						  " id="continent_<?= $lang->code ?>">
							<input type="text" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
						  </div>
						<?php $v80360698133360704331incr++; } ?>

					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>

<div id="edit_continents_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			   	<?php if ($settings->modal_image) { ?>
			 	  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
			   	<?php } else { ?>
			   	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
			   	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="1">
			<input type="hidden" name="geo_id" id="continent_id">
			 <fieldset>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Continent Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_continent_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_continent_<?= $lang->code ?>">
					  			<input type="text" id="continent_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>
<?php } ?>

<?php if ($settings->enable_countries) { ?>
<div id="countries" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
		  	  	<?php if ($settings->modal_image) { ?>
		  		  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	  	<?php } else { ?>
		  	  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="2">
			 <fieldset>
			 	<?php if ($settings->enable_continents) { ?>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select continent</label>
				   <div class="col-sm-8">
					  <select id="edit_country_parent" name="parent_id" class="form-control m-b">
						 <?php $v80360698133360704331iterator = $continents; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $continent) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $continent->id ?>"><?= $continent->getName() ?></option>
						 <?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>
				<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Country Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						  <li class="active">
							  <a href="#countries_ar" data-toggle="tab"> <small> Ar </small></a>
						  </li>
						  <li>
							  <a href="#countries_en" data-toggle="tab"><small> En </small> </a>
						  </li>
					  </ul>
					  <div class="tab-content clearfix">
						  <div class="tab-pane active" id="countries_ar">
							<input type="text" class="form-control" name="geo_ar_name" placeholder="العربية">
						  </div>

						  <div class="tab-pane" id="countries_en">
							<input type="text" class="form-control" name="geo_en_name" placeholder="English">
						  </div>
					 </div>
				  </div>
				</div>

			  </fieldset>
		      <div class="col-xs-12">
		  	  	<button type="submit" class="btn btn-sm btn-success">Save</button>
		  	  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
		      </div>
		  </form>
	  </div>
	</div>

  </div>
</div>

<div id="edit_country_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="2">
			<input type="hidden" name="geo_id" id="country_id" >
			 <fieldset>
			 	<?php if ($settings->enable_continents) { ?>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select continent</label>
				   <div class="col-sm-8">
					  <select name="parent_id" class="form-control m-b">
						 <?php $v80360698133360704331iterator = $continents; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $continent) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $continent->id ?>"><?= $continent->getName() ?></option>
						 <?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>
				<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Country Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_country_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_country_<?= $lang->code ?>">
					  			<input type="text" id="country_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>

			  </fieldset>
		      <div class="col-xs-12">
		  	  	<button type="submit" class="btn btn-sm btn-success">Save</button>
		  	  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
		      </div>
		  </form>
	  </div>
	</div>

  </div>
</div>
<?php } ?>

<?php if ($settings->enable_states) { ?>
<div id="states" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="3">
			 <fieldset>

			 	<?php if ($settings->enable_countries) { ?>
			 	<div class="form-group">
			 	   <label class="col-sm-4 control-label">Select Country</label>
			 	   <div class="col-sm-8">
			 		  <select name="parent_id" class="form-control m-b">
			 		  	<?php $v80360698133360704331iterator = $countries; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $country) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
			 			 <option value="<?= $country->id ?>"><?= $country->getName() ?></option>
			 			<?php $v80360698133360704331incr++; } ?>
			 		  </select>
			 	   </div>
			 	</div>
			 	<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">State Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						  <li class="active">
							  <a href="#state_ar" data-toggle="tab"> <small> Ar </small></a>
						  </li>
						  <li>
							  <a href="#state_en" data-toggle="tab"><small> En </small> </a>
						  </li>
					  </ul>
					  <div class="tab-content clearfix">
						  <div class="tab-pane active" id="state_ar">
							<input type="text" class="form-control" name="geo_ar_name" placeholder="العربية">
						  </div>

						  <div class="tab-pane" id="state_en">
							<input type="text" class="form-control" name="geo_en_name" placeholder="English">
						  </div>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>

<div id="edit_state_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="3">
			<input type="hidden" name="geo_id" id="state_id">
			 <fieldset>

			 	<?php if ($settings->enable_countries) { ?>
			 	<div class="form-group">
			 	   <label class="col-sm-4 control-label">Select Country</label>
			 	   <div class="col-sm-8">
			 		  <select id="edit_state_parent" name="parent_id" class="form-control m-b">
			 		  	<?php $v80360698133360704331iterator = $countries; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $country) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
			 			 <option value="<?= $country->id ?>"><?= $country->getName() ?></option>
			 			<?php $v80360698133360704331incr++; } ?>
			 		  </select>
			 	   </div>
			 	</div>
			 	<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">State Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_state_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_state_<?= $lang->code ?>">
					  			<input type="text" id="state_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>
<?php } ?>

<?php if ($settings->enable_city) { ?>
<div id="cities" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="4">
			 <fieldset>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select State</label>
				   <div class="col-sm-8">
					  <select id="edit_city_parent" name="parent_id" class="form-control m-b">
					  	<?php $v80360698133360704331iterator = $states; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $state) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $state->id ?>"><?= $state->getName() ?></option>
						<?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>

				<div class="form-group">
				   <label class="col-sm-4 control-label">City Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						  <li class="active">
							  <a href="#city_ar" data-toggle="tab"> <small> Ar </small></a>
						  </li>
						  <li>
							  <a href="#city_en" data-toggle="tab"><small> En </small> </a>
						  </li>
					  </ul>
					  <div class="tab-content clearfix">
						  <div class="tab-pane active" id="city_ar">
							<input type="text" class="form-control" name="geo_ar_name" placeholder="العربية">
						  </div>

						  <div class="tab-pane" id="city_en">
							<input type="text" class="form-control" name="geo_en_name" placeholder="English">
						  </div>
					 </div>
				  </div>
				</div>

			  </fieldset>
			  <div class="col-xs-12">
			  	<button type="submit" class="btn btn-sm btn-success">Save</button>
			  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			  </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>

<div id="edit_city_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="4">
			<input type="hidden" name="geo_id" id="city_id">
			 <fieldset>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select State</label>
				   <div class="col-sm-8">
					  <select name="parent_id" class="form-control m-b">
					  	<?php $v80360698133360704331iterator = $states; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $state) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $state->id ?>"><?= $state->getName() ?></option>
						<?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>

				<div class="form-group">
				   <label class="col-sm-4 control-label">City Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_city_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_city_<?= $lang->code ?>">
					  			<input type="text" id="city_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>
				  <div class="col-xs-12">
					<button type="submit" class="btn btn-sm btn-success">Save</button>
					<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
				  </div>
			  </fieldset>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>
<?php } ?>

<?php if ($settings->enable_regions) { ?>
<div id="regions" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="5">
			 <fieldset>

			 	<?php if ($settings->enable_city) { ?>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select City</label>
				   <div class="col-sm-8">
					  <select name="parent_id" class="form-control m-b">
						 <?php $v80360698133360704331iterator = $cities; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $city) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $city->id ?>"><?= $city->getName() ?></option>
						 <?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>
				<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Region Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						  <li class="active">
							  <a href="#region_ar" data-toggle="tab"> <small> Ar </small></a>
						  </li>
						  <li>
							  <a href="#region_en" data-toggle="tab"><small> En </small> </a>
						  </li>
					  </ul>
					  <div class="tab-content clearfix">
						  <div class="tab-pane active" id="region_ar">
							<input type="text" class="form-control" name="geo_ar_name" placeholder="العربية">
						  </div>

						  <div class="tab-pane" id="region_en">
							<input type="text" class="form-control" name="geo_en_name" placeholder="English">
						  </div>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>

<div id="edit_region_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form id="edit_region_form" method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="5">
			<input type="hidden" name="geo_id" id="region_id">
			 <fieldset>

			 	<?php if ($settings->enable_city) { ?>
				<div class="form-group">
				   <label class="col-sm-4 control-label">Select City</label>
				   <div class="col-sm-8">
					  <select id="edit_region_parent" name="parent_id" class="form-control m-b">
						 <?php $v80360698133360704331iterator = $cities; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $city) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						 <option value="<?= $city->id ?>"><?= $city->getName() ?></option>
						 <?php $v80360698133360704331incr++; } ?>
					  </select>
				   </div>
				</div>
				<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Region Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_region_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_region_<?= $lang->code ?>">
					  			<input type="text" id="region_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>
<?php } ?>

<?php if ($settings->enable_streets) { ?>
<div id="streets" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/store') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="6">
			 <fieldset>

			 	<?php if ($settings->enable_regions) { ?>
			 	<div class="form-group">
			 	   <label class="col-sm-4 control-label">Select Region</label>
			 	   <div class="col-sm-8">
			 		  <select name="parent_id" class="form-control m-b">
			 		  	<?php $v80360698133360704331iterator = $regions; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $region) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
			 			 <option value="<?= $region->id ?>"><?= $region->getName() ?></option>
			 			<?php $v80360698133360704331incr++; } ?>
			 		  </select>
			 	   </div>
			 	</div>
			 	<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Street Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						  <li class="active">
							  <a href="#street_ar" data-toggle="tab"> <small> Ar </small></a>
						  </li>
						  <li>
							  <a href="#street_en" data-toggle="tab"><small> En </small> </a>
						  </li>
					  </ul>
					  <div class="tab-content clearfix">
						  <div class="tab-pane active" id="street_ar">
							<input type="text" class="form-control ar-name" name="geo_ar_name" placeholder="العربية">
						  </div>

						  <div class="tab-pane" id="street_en">
							<input type="text" class="form-control en-name" name="geo_en_name" placeholder="English">
						  </div>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>

<div id="edit_street_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header hidden-xs">
		  <div class=" col-xs-12 ">
			  <?php if ($settings->modal_image) { ?>
			  <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/geo-new.png') center center no-repeat ; background-size: contain"></div>
		  	<?php } else { ?>
		  	<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url(<?= $this->url->getStatic('ropo_app/img/banners/geo-new.png') ?>) center center no-repeat ; background-size: contain"></div>
		  	<?php } ?>
		  </div>
	  </div>
	  <div class="modal-body">
		<form method="post" action="<?= $this->url->get('index/update') ?>" class="form-horizontal">
			<input type="hidden" name="type" value="6">
			<input type="hidden" name="geo_id" id="street_id">
			 <fieldset>

			 	<?php if ($settings->enable_regions) { ?>
			 	<div class="form-group">
			 	   <label class="col-sm-4 control-label">Select Region</label>
			 	   <div class="col-sm-8">
			 		  <select id="edit_street_parent" name="parent_id" class="form-control m-b">
			 		  	<?php $v80360698133360704331iterator = $regions; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $region) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
			 			 <option value="<?= $region->id ?>"><?= $region->getName() ?></option>
			 			<?php $v80360698133360704331incr++; } ?>
			 		  </select>
			 	   </div>
			 	</div>
			 	<?php } ?>

				<div class="form-group">
				   <label class="col-sm-4 control-label">Street Name</label>
					
				   <div class="col-sm-8">
					  <ul  class="nav nav-tabs">
						   	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
						  	  <li class="
						  	  <?php if ($v80360698133360704331loop->first) { ?>
						  	  active
						  	  <?php } ?>
						  	  ">
						  		  <a href="#edit_street_<?= $lang->code ?>" data-toggle="tab"> <small> <?= $lang->code ?> </small></a>
						  	  </li>
						  	<?php $v80360698133360704331incr++; } ?>
					  </ul>
					  <div class="tab-content clearfix">
					  	  	<?php $v80360698133360704331iterator = $langs; $v80360698133360704331incr = 0; $v80360698133360704331loop = new stdClass(); $v80360698133360704331loop->self = &$v80360698133360704331loop; $v80360698133360704331loop->length = count($v80360698133360704331iterator); $v80360698133360704331loop->index = 1; $v80360698133360704331loop->index0 = 1; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - 1; ?><?php foreach ($v80360698133360704331iterator as $lang) { ?><?php $v80360698133360704331loop->first = ($v80360698133360704331incr == 0); $v80360698133360704331loop->index = $v80360698133360704331incr + 1; $v80360698133360704331loop->index0 = $v80360698133360704331incr; $v80360698133360704331loop->revindex = $v80360698133360704331loop->length - $v80360698133360704331incr; $v80360698133360704331loop->revindex0 = $v80360698133360704331loop->length - ($v80360698133360704331incr + 1); $v80360698133360704331loop->last = ($v80360698133360704331incr == ($v80360698133360704331loop->length - 1)); ?>
					  		  <div class="tab-pane
					  		  <?php if ($v80360698133360704331loop->first) { ?>
					  		  active
					  		  <?php } ?>
					  		  " id="edit_street_<?= $lang->code ?>">
					  			<input type="text" id="street_<?= $lang->code ?>_name" class="form-control" name="geo_<?= $lang->code ?>_name" placeholder="<?= $lang->title ?>">
					  		  </div>
					  		<?php $v80360698133360704331incr++; } ?>
					 </div>
				  </div>
				</div>

			  </fieldset>
			    <div class="col-xs-12">
				  	<button type="submit" class="btn btn-sm btn-success">Save</button>
				  	<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
			    </div>
		  </form>
	  </div>
	  
	</div>

  </div>
</div>
<?php } ?>

<script type="text/javascript">
function deletePlace(type, id) {
	if(confirm("Are you sure you want to delete this place?")){
		window.location = "<?= $this->url->get('index/delete') ?>" + "/" +id+"?type=" + type;
	}
}

function editRegion(id){
	$("#region_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=5",
		success: function(response){
			// $("#region_ar_name").val(response.ar.name);
			// $("#region_en_name").val(response.en.name);
			$("#edit_region_parent").val(response.city_id);
			console.log(response.ar);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#region_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}

function editContinent(id){
	$("#continent_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=1",
		success: function(response){
			console.log(response.langs);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#continent_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}

function editCountry(id){
	$("#country_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=2",
		success: function(response){
			// $("#country_ar_name").val(response.ar.name);
			// $("#country_en_name").val(response.en.name);
			$("#edit_country_parent").val(response.continent_id);
			console.log(response.ar);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#country_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}

function editCity(id){
	$("#city_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=4",
		success: function(response){
			// $("#city_ar_name").val(response.ar.name);
			// $("#city_en_name").val(response.en.name);
			$("#edit_city_parent").val(response.state_id);
			console.log(response.ar);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#city_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}

function editState(id){
	$("#state_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=3",
		success: function(response){
			// $("#state_ar_name").val(response.ar.name);
			// $("#state_en_name").val(response.en.name);
			console.log(response.ar);
			$("#edit_state_parent").val(response.country_id);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#state_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}

function editStreet(id){
	$("#street_id").val(id);
	$.ajax({
		method: "GET",
		url: "<?= $this->url->get('index/view') . '/' ?>" + id + "?type=6",
		success: function(response){
			// $("#street_ar_name").val(response.ar.name);
			// $("#street_en_name").val(response.en.name);
			$("#edit_street_parent").val(response.region_id);
			console.log(response.ar);
			for(var lang in response.langs){
				if (response.langs.hasOwnProperty(lang)) {
					$("#street_"+lang+"_name").val(response.langs[lang].name);
				}
			}
		}
	})
}
</script>
