

<tbody>
	<tr>
		<td style="padding:40px 0  0 0;">
			<p style="color:#000;font-size: 16px;line-height:24px;font-family:'HelveticaNeue','Helvetica Neue',Helvetica,Arial,sans-serif;font-weight:normal;">

				<h2 style="font-size: 14px;font-family:'HelveticaNeue','Helvetica Neue',Helvetica,Arial,sans-serif;">Your New Account</h2>

				<p style="font-size: 13px;line-height:24px;font-family:'HelveticaNeue','Helvetica Neue',Helvetica,Arial,sans-serif;">
					Your UserName is
					<br>
					<br>
					<span>{{newUser}}</span>

					Your New Password is 
				<br>
				<br>
				<span>{{newPass}}</span>

					لتفعيل العضوية اضغط على الرابط التالي
					<br>
					<br>
					<span><a href="{{url('charity/activate/') ~secret_code}}">{{url('charity/activate/') ~secret_code}}</a></span>
				Thank you !
				<br>
			</p>
		</td>
	</tr>
</tbody>

