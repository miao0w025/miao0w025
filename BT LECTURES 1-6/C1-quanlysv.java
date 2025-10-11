import java.util.*;

class SinhVien {
    private String ma, ten, ns;
    private double gpa;

    public SinhVien(String ma, String ten, String ns, double gpa) {
        this.ma = ma;
        this.ten = ten;
        this.ns = ns;
        this.gpa = gpa;
    }

    public String getMa() { return ma; }
    public String getTen() { return ten; }
    public String getNs() { return ns; }
    public double getGpa() { return gpa; }
    public void setTen(String ten) { this.ten = ten; }
    public void setNs(String ns) { this.ns = ns; }
    public void setGpa(double gpa) { this.gpa = gpa; }

    public String toString() {
        return String.format("%-8s | %-20s | %-10s | %.2f", ma, ten, ns, gpa);
    }
}

public class QuanLySV {
    private static ArrayList<SinhVien> ds = new ArrayList<>();
    private static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        while (true) {
            System.out.println("\n1.Them SV  2.Hien thi  3.Tim theo ma  4.Sap xep theo GPA  5.Xoa theo ma  6.Thoat");
            System.out.print("Lua chon: ");
            String c = sc.nextLine().trim();
            switch (c) {
                case "1": themSV(); break;
                case "2": hienThi(); break;
                case "3": timTheoMa(); break;
                case "4": sapXepGPA(); break;
                case "5": xoaTheoMa(); break;
                case "6": System.exit(0);
                default: System.out.println("Lua chon khong hop le");
            }
        }
    }

    private static void themSV() {
        System.out.print("Nhap ma: "); String ma = sc.nextLine().trim();
        System.out.print("Nhap ten: "); String ten = sc.nextLine().trim();
        System.out.print("Nhap ngay sinh: "); String ns = sc.nextLine().trim();
        System.out.print("Nhap gpa: "); double gpa = Double.parseDouble(sc.nextLine().trim());
        ds.add(new SinhVien(ma, ten, ns, gpa));
        System.out.println("Da them sinh vien.");
    }

    private static void hienThi() {
        System.out.println("\nMa       | Ten                  | NgaySinh   | GPA");
        for (SinhVien sv : ds) System.out.println(sv);
    }

    private static void timTheoMa() {
        System.out.print("Nhap ma can tim: "); String ma = sc.nextLine().trim();
        for (SinhVien sv : ds) {
            if (sv.getMa().equalsIgnoreCase(ma)) {
                System.out.println("\nTim thay:");
                System.out.println("Ma       | Ten                  | NgaySinh   | GPA");
                System.out.println(sv);
                return;
            }
        }
        System.out.println("Khong tim thay sinh vien.");
    }

    private static void sapXepGPA() {
        ds.sort((a, b) -> Double.compare(b.getGpa(), a.getGpa()));
        System.out.println("Da sap xep giam dan theo GPA.");
    }

    private static void xoaTheoMa() {
        System.out.print("Nhap ma can xoa: "); String ma = sc.nextLine().trim();
        Iterator<SinhVien> it = ds.iterator();
        while (it.hasNext()) {
            if (it.next().getMa().equalsIgnoreCase(ma)) {
                it.remove();
                System.out.println("Da xoa sinh vien.");
                return;
            }
        }
        System.out.println("Khong tim thay sinh vien.");
    }
}
