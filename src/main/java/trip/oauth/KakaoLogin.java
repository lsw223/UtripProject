package trip.oauth;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KakaoLogin {
	
	// 토큰 받기
	public JSONObject getKakaoToken(String code) {
		JSONObject json = new JSONObject();
		String apiUrl = "https://kauth.kakao.com/oauth/token"; 
		try {
			URL url = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			String postParams = "";
			postParams += "grant_type=authorization_code";
			postParams += "&client_id=38ad5f7eaf5e40dc6b4d7274dabc0268";
			postParams += "&redirect_uri=http://localhost:9999/kakaoLogin.do";
			postParams += "&code="+code;
			DataOutputStream dos = new DataOutputStream(conn.getOutputStream());
			dos.writeBytes(postParams);
			dos.flush();
			dos.close();
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String responseBody = "";
			while(true) {
				String str = br.readLine();
				if(str == null) break;
				responseBody += str;
			}
			json = new JSONObject(responseBody);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	//사용자 정보 가져오기 , 현재 카카오톡으로 로그인한 사용자의 정보를 불러옵니다.
	public JSONObject getKakaoUser(String token) {
		JSONObject json = new JSONObject();
		String apiUrl = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer "+token);
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String responseBody = "";
			while(true) {
				String str = br.readLine();
				if(str==null) break;
				responseBody += str;
			}
			json = new JSONObject(responseBody);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	
}
