class NhanVien {
    private String ten;
    private double luong;

    public NhanVien(String ten, double luong) {
        this.ten = ten;
        this.luong = luong;
    }

    public String getTen() {
        return ten;
    }

    public double getLuong() {
        return luong;
    }

    public void setLuong(double luong) {
        if (luong > 0) this.luong = luong;
    }
}

public class Main {
    public static void main(String[] args) {
        NhanVien nv = new NhanVien("An", 5000);
        nv.setLuong(6000);
        System.out.println("Tên: " + nv.getTen() + ", Lương: " + nv.getLuong());
    }
}
