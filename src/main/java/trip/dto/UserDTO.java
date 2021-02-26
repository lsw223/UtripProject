package trip.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import trip.enums.RoleType;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("user")
@Builder
public class UserDTO {
	private String id;
	private String password;
	private String name;
	private RoleType role;
	private String mbti;
	private String email;
}
