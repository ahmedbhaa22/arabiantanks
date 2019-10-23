{{ content() }}

<header class="jumbotron subhead" id="overview">
	<div class="hero-unit">
		<h1>أهلاً وسهلاً!</h1>
		<p class="lead"></p>

		<div align="right">
      {{ link_to('session/signup', '<i class="icon-ok icon-white"></i> سجل عضوية', 'class': 'btn btn-primary btn-large') }}
		</div>
		<div align="left">
			{{ link_to('session/login', '<i class="icon-ok icon-white"></i> تسجيل الدخول', 'class': 'btn btn-primary btn-large') }}
		</div>
	</div>
</header>
