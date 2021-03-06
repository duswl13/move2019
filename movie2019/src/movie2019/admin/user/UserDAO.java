package movie2019.admin.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	int result;
	
	public UserDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");

		} catch (Exception ex) {
			System.out.println("DB 접근 에러 : " + ex);
		}
	}
	
	public int isId(String id) {
		try {
			con=ds.getConnection();
			System.out.println("getConnection");
			
			String sql="select id from users where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=0;		
			}else {
				result=-1;		
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					pstmt.close();
				}catch(SQLException ex){
					ex.printStackTrace();					
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return result;
	}
	

	public Users user_info(String id) {
		Users m= null;
		try {
			con=ds.getConnection();			
			String sql= "select * from USERS where USER_ID=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				m=new Users();
				m.setUSER_ID(rs.getString(1));
				m.setUSER_PASS(rs.getString(2));
				m.setUSER_EMAIL(rs.getString(3));
				m.setUSER_JOIN_DATE(rs.getDate(4));
				m.setUSER_PHONE(rs.getString(5));
				m.setUSER_TYPE(rs.getString(6));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {
				try {
					pstmt.close();
				}catch(SQLException ex){
					ex.printStackTrace();					
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return m;
	}


	public List<Users> getList(){
		List<Users> list = new ArrayList<Users>();
		try {
			con = ds.getConnection();
			String sql = "select * from users";

			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				Users m = new Users();
				m.setUSER_ID(rs.getString(1));
				m.setUSER_PASS(rs.getString(2));
				m.setUSER_EMAIL(rs.getString(3));
				m.setUSER_JOIN_DATE(rs.getDate(4));
				m.setUSER_PHONE(rs.getString(5));
				m.setUSER_TYPE(rs.getString(6));
				list.add(m);
			}

		} catch(java.sql.SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public int getListCount() {
		int x = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select count(*) from users");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCount() 에러: " + e);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return x;
	}

	public List<Users> getList(int page, int limit) {
		

		 String sql = "select * "
			      +" from (select b.*, rownum rnum " 
			      + " from (select * from users "
			      +" order by user_id) b"
			      +" )"
			      +" where rnum >=? and rnum <= ?";

		

		List<Users> list = new ArrayList<Users>();

		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Users user = new Users();
				user.setUSER_ID(rs.getString("USER_ID"));
				user.setUSER_PASS(rs.getString("USER_PASS"));
				user.setUSER_EMAIL(rs.getString("USER_EMAIL"));
				user.setUSER_JOIN_DATE(rs.getDate("USER_JOIN_DATE"));
				user.setUSER_PHONE(rs.getString("USER_PHONE"));
				user.setUSER_TYPE(rs.getString("USER_TYPE"));

				list.add(user);
			}
			return list; 
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getList() 에러: " + e);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return null;
	}

	public int delete(String id) {
		result=0;
		try {
			con=ds.getConnection();
			
			String sql="delete from users where USER_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("delete() 에러: " + e);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return result;
	}

	public int user_update(Users u) {
		int result = 0;
		try {
			con = ds.getConnection();
			String sql = "update users set USER_PASS=?, USER_EMAIL=?, USER_PHONE=? where USER_ID=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, u.getUSER_PASS());
			pstmt.setString(2, u.getUSER_EMAIL());
			pstmt.setString(3, u.getUSER_PHONE());
			pstmt.setString(4, u.getUSER_ID());

			result = pstmt.executeUpdate();
			System.out.println("updatetest"+result);

		} catch(java.sql.SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return result;
	}

	public String getPassword(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean isMember(String pass, String parameter) {
		// TODO Auto-generated method stub
		return false;
	}

}
