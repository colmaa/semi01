package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.JdbcUtil;
import test.vo.MovieVo;

public class MovieDao {
	private static MovieDao instance = new MovieDao();
	private MovieDao() {}
	public static MovieDao getInstance() {
		return instance;
	}
	
	public ArrayList<MovieVo> selectAll(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from movie";
			con = JdbcUtil.getCon();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<MovieVo> list = new ArrayList<MovieVo>();
			while(rs.next()) {
				int mnum = rs.getInt("mnum");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String director = rs.getString("director");
				MovieVo vo = new MovieVo(mnum, title, content, director);
				list.add(vo);
			}
			return list;
		}catch (SQLException s) {
			s.printStackTrace();
			return null;
		}finally {
			JdbcUtil.close(con, pstmt, rs);
		}
	}
	public MovieVo select(int mnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from movie where mnum=?";
			con = JdbcUtil.getCon();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				String director = rs.getString("director");
				MovieVo vo = new MovieVo(mnum, title, content, director);
				return vo;
			}
			return null;
		}catch (SQLException s) {
			s.printStackTrace();
			return null;
		}finally {
			JdbcUtil.close(con, pstmt, rs);
		}
	}
}
